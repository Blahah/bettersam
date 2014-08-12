#define _BSIZE 100000

typedef struct {
  char *line;
  char *qname;
  char *flag;
  char *rname;
  char *pos;
  char *mapq;
  char *cigar;
  char *rnext;
  char *pnext;
  char *tlen;
  char *seq;
  char *qual;
  char *tags;
  char *filename;
  FILE *stream;
} SAMRecord;
