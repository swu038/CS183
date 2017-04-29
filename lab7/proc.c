/*
 * proc.c
 *
 * A simple program to simulate various scenarios to stress test a
 * Linux/Unix system.
 *
 * This was created for CS183 Unix System Administration, Summer '07
 * at University of Califorina, Riverside.
 *
 * Author: WeeSan Lee <weesan@cs.ucr.edu>
 * Created on: 7/6/07
 *
 * $Log: proc.c,v $
 * Revision 1.2  2008/04/27 04:43:19  weesan
 * Added fake process name disguise.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>

#define PROC_FAKE_NAME_DISGUISE
#define PROC_DEFAULT_SLEEP_SEC  5
#define PROC_DEFAULT_RENICE     +1

static void disguise(int argc, char *argv[]) {
    int i, j;

    // Seed the random generator
    srand(time(NULL));
    // Disguise the process name
#ifdef PROC_FAKE_NAME_DISGUISE
    static char *fake_name[] = {
	"arch",	  	  "etag",   	    "init",   	      "rpm",
	"arp",	  	  "find",   	    "ip",     	      "sh",
	"awk",	  	  "flex",   	    "irq",    	      "sort",
	"bash",	  	  "free",   	    "kded",   	      "sshd",
	"bc",	  	  "ftp",    	    "kwin",   	      "sync",
	"cal",	  	  "g++",    	    "ld",     	      "tail",
	"cat",	  	  "gawk",   	    "less",   	      "talk",
	"cmp",	  	  "gcc",    	    "lpr",    	      "tar",
	"cpio",	  	  "git",    	    "ls",     	      "tcp",
	"cut",	  	  "gpm",    	    "mail",   	      "tcsh",
	"dbus",	  	  "grep",   	    "mv",     	      "tee",
	"dc",	  	  "gs",	    	    "nc",     	      "tgif",
	"dd",	  	  "gv",	    	    "nc",     	      "top",
	"df",	  	  "gzip",   	    "nice",   	      "vi",
	"dig",	  	  "hald",   	    "nop",    	      "who",
	"dmesg",  	  "head",   	    "ping",   	      "zcat",
	"echo",	  	  "http",   	    "ps",     	      "zcat",
	"esd",	  	  "info",   	    "rm",     	      "zsh",
    };
    // Fill the name with blank first
    memset(argv[0], ' ', sizeof(argv[0]));
    // Fake it with something in random
    while (1) {
	i = random() % (sizeof(fake_name) / sizeof(char *));
	if (strlen(fake_name[i]) <= strlen(argv[0])) {
	    strcpy(argv[0], fake_name[i]);
	    break;
	}
    }
#else
    for (i = 0; i < strlen(argv[0]); i++) {
	do {
	    j = random() % 256;
	} while (!isalnum(j));
	argv[0][i] = j;
    }
#endif
    // Hide the options
    for (i = 1; i < argc; i++) {
	for (j = 0; j < strlen(argv[i]); j++) {
	    argv[i][j] = ' ';
	}
    }
}

static void fork_proc(int nproc, int sleep_sec, int zombie) {
    int i = 0;
    int count = 0;
    pid_t pid = 0;
    for (i = 0; i < nproc; i++) {
	switch (pid = fork()) {
	case -1:
	    // Error
	    fprintf(stderr,
		    "Failed to call fork(): %s\n", strerror(errno));
	    break;
	case 0:
	    // Child
	    if (!zombie) {
		sleep(sleep_sec);
	    }
	    exit(0);
	    break;
	default:
	    // Parent
	    printf("Child process %d was created.\n", pid);
	    count++;
	    break;
	}
    }

    // Only the parent will wait for child processes
    if (pid) {
	if (zombie) {
	    printf("%d child processes were created and "
		   "will become zombie for %d secs.\n",
		   count, sleep_sec);
	    sleep(sleep_sec);
	} else {
	    printf("%d child processes were created and "
		   "will sleep for %d sec.\n",
		   count, sleep_sec);
	}
	count = 0;
	for (i = 0; i < nproc; i++) {
	    pid_t cpid = wait(NULL);
	    if (cpid > 0) {
		count++;
		printf("Child process %d exited.\n", cpid);
	    }
	}
	printf("%d child processes ended.\n", count);
    }
}


static void hogging_cpu(void) {
    // Renice itself before hogging the cpu
    if (nice(PROC_DEFAULT_RENICE) < 0) {
	fprintf(stderr,
		"Failed to renice myself: %s\n", strerror(errno));
    }
    while (1) {
	// Do mothing but hogging the cpu
    }
}

static void create_files(int no_of_file, int sleep_sec) {
    int *fds = NULL;
    char file[256];
    int count = 0;
    int i = 0;

    fds = malloc(sizeof(int) * no_of_file);
    for (i = 0; i < no_of_file; i++) {
	snprintf(file, sizeof(file), "file_%d.tmp", i);
	if ((fds[i] = open(file, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR)) < 0) {
	    fprintf(stderr,
		    "Failed to create %s: %s\n", file, strerror(errno));
	} else {
	    count++;
	}
    }
    printf("%d files opened.\n", count);

    printf("Sleeping for %d sec before closing and deleting files ...\n",
	   sleep_sec);
    sleep(sleep_sec);

    count = 0;
    for (i = 0; i < no_of_file; i++) {
	if (fds[i] > 0) {
	    close(fds[i]);
	    snprintf(file, sizeof(file), "file_%d.tmp", i);
	    if (unlink(file) < 0) {
		fprintf(stderr,
			"Failed to delete %s: %s\n", file, strerror(errno));
	    } else {
		count++;
	    }
	}
    }
    printf("%d files deleted.\n", count);

    free(fds);
}

static void allocate_memory(int mem_size, int sleep_sec) {
    char *s = malloc(mem_size);
    if (s == NULL) {
	fprintf(stderr,
		"Failed to allocate %d bytes of memory: %s\n",
		mem_size, strerror(errno));
    } else {
	printf("Sleeping for %d sec before freeing memory of %d bytes ...\n",
	       sleep_sec, mem_size);
	sleep(sleep_sec);
	free(s);
    }
}

int main(int argc, char *argv[]) {
    int opt = 0;
    int nproc = 0;
    int nofile = 0;
    int mem_size = 0;
    int sleep_sec = PROC_DEFAULT_SLEEP_SEC;
    int hog_cpu = 0;
    int zombie = 0;

    if (argc == 1) {
	fprintf(stderr,
		"Usage: %s "
		"[-f #_of_file] "
		"[-h] "
		"[-m mem_size] "
		"[-n nproc] "
		"[-s sec] "
		"[-z] "
		"\n",
		argv[0]);
	return (1);
    }

    while ((opt = getopt(argc, argv, "f:hm:n:s:z")) != -1) {
	switch (opt) {
	case 'f':
	    nofile = atoi(optarg);
	    break;
	case 'h':
	    hog_cpu = 1;
	    break;
	case 'm':
	    mem_size = atoi(optarg);
	    break;
	case 'n':
	    nproc = atoi(optarg);
	    break;
	case 's':
	    sleep_sec = atoi(optarg);
	    break;
	case 'z':
	    zombie = 1;
	    break;
	default:
	    fprintf(stderr, "Unknown option: %c\n", opt);
	    break;
	}
    }

    // Disguise myself into something else
    disguise(argc, argv);

    argc -= optind;
    argv += optind;

    if (nofile) {
	create_files(nofile, sleep_sec);
    }

    if (mem_size) {
	allocate_memory(mem_size, sleep_sec);
    }

    if (hog_cpu) {
	hogging_cpu();
    }

    if (nproc) {
	fork_proc(nproc, sleep_sec, zombie);
    }

    return (0);
}
