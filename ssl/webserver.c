#define HTTP_PORT 80
#define DEFAULT_LINE_LEN 255

static void process_http_request(int connection) {
  char *request_line;
  request_line = read_line(connection);
  if (strncmp(request_line, "GET", 3)) {
	// only support "GET"
	build_error_response(connection,501);
  } else {
	// skip over all header lines, don't care
	while (strcmp(read_line(connection), ""));
	build_success_response(connection);
  }

  if (close(connection) == -1) {
	perror("Unable to close connection.");
  }
}

char *read_line(int connection) {
  static int line_len = DEFAULT_LINE_LEN;
  static char *line = NULL;
  int size;
  char c; // must be char, not int
  int pos = 0;

  if (!line) {
	line = malloc(line_len);
  }

  while ((size = recv(connection, &c, 1, 0)) > 0) {
	if ((c=='\n') && (line[pos-1]=='\r')) {
	  line[pos-1]='\0';
	  break;
	}

	line[pos++] = c;
	if (pos > line_len) {
	  line_len *= 2;
	  line = realloc(line, line_len);
	}
  }

  return line;
}

