#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

// buffer size for reading in a single record
#define _BSIZE 100000

// we define string literals and a lookup
// table so we can rapidly find the tags we
// want to keep
#define NUM_TAGS (2)
#define XM       ("XM") // alignment mismatches
#define NM       ("NM") // edit distance
char *tagTable[NUM_TAGS] = {XM, NM};
typedef enum {
  XM_TAG = 0,
  NM_TAG
} enumTags;

// we define null (default) values for each tag
// these values are equivalent to the tag not being
// present
#define XM_TAG_NULL 0 // alignment mismatches
#define NM_TAG_NULL 0 // edit distance

// holds tags parsed from the optional fields
// of a SAM record
typedef struct {
  int xm; // alignment mismatches
  int nm; // edit distance
} SAMTagSet;

// holds a SAM record with all compulsory fields
// explicitly defined. Optional fields are nested
// in the tags field
typedef struct {
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
  SAMTagSet *tags;
  char *filename;
  char *line;
  FILE *stream;
} SAMRecord;
