var fs = require('fs');
fs.open('/tmp/my_file.txt', 'a', function opened(err, fd) {
    if (err) {
        throw err;
    }

    var writeBuf = new Buffer('writing this string'),
        bufPos = 0,
        bufLen = writeBuf.length,
        filePos = null;

    fs.write(fd, writeBuf, bufPos, bufLen, filePos, function wrote(err, written) {
        if (err) {
            throw err;
        }
        console.log('wrote ' + written + ' bytes');
    });
});

