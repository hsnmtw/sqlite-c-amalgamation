#include <stdio.h>
#include <stdlib.h>
#include "sqlite3.h"

int callback(void *db,int argc,char** values, char** columns) {
    for (size_t i=0; i<argc; ++i) {
        printf("%s = '%s' | ", columns[i], values[i]);
    }
    printf("\n");
    return 0;
}

void sqlite_error_check(sqlite3 *db, int rc) {
    if (rc == SQLITE_OK) return;
    char *err = sqlite3_errmsg(db);
    fprintf(stderr, "SQLITE ERROR: %s\n", err);
    sqlite3_free(err);
    exit(1);
}

int main(int argc, char **argv) {
    sqlite3 *db;
    int rc = sqlite3_open("test.sqlite3", &db);
    sqlite_error_check(db,rc);

    char **errmsg = 0;
    rc = sqlite3_exec(db,"CREATE TABLE IF NOT EXISTS TEST(ID INTEGER PRIMARY KEY, NAME TEXT);",&callback,0,errmsg);
    sqlite_error_check(db,rc);
    
    rc = sqlite3_exec(db,"INSERT INTO TEST(name) SELECT 'test only';",&callback,0,errmsg);
    sqlite_error_check(db,rc);

    rc = sqlite3_exec(db,"SELECT * from test;",&callback,0,errmsg);
    sqlite_error_check(db,rc);

    printf("Successfully connected to sqlite db using c\n");
    sqlite3_close(db);
    return 0;
}
