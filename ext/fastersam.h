#define _BSIZE 100000

typedef struct {
  char *line;
  char *qname;
  int flag;
  char *rname;
  int pos;
  int mapq;
  char *cigar;
  char *rnext;
  int pnext;
  int tlen;
  char *seq;
  char *qual;
  char *tags;
  char *filename;
  FILE *stream;
} SAMRecord;
