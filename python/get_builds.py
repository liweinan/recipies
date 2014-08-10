import sys
import subprocess
import os
import json
import pprint
import koji

def print_stuff(list_to_print):
    for item in list_to_print:
        print item


def runmeoutput(cmd, cwd, capture_stderr=False):

    if capture_stderr:
        ferr = subprocess.STDOUT
    else:
        ferr = open(os.devnull, 'w')

    try:
        pid = subprocess.Popen(cmd, cwd=cwd,
                               stdout=subprocess.PIPE, stderr=ferr)
        result = pid.communicate()[0].rstrip('\n')
        return result
    except (subprocess.CalledProcessError, OSError):
        print("Command: '{0}' failed! Directory: {1}".format(" ".join(cmd), cwd))
        raise Exception('Command failed')

advisory = sys.argv[1]

command_nvr = "curl --user ':' --negotiate " \
              "https://errata.devel.redhat.com/advisory/{0}/" \
              "builds.json " \
              "-k".format(advisory)

json_output = runmeoutput(command_nvr.split(), '.')
json_result = json.loads(json_output)

key = json_result.keys()[0]
nvrs = []
names = []
for item in json_result[key]:
    build = item.keys()[0]
    nvrs.append(build)
    name = koji.parse_NVR(build)['name']
    names.append(name)

print('----------------------')
print("Nvrs in errata:")
print('----------------------')
print_stuff(sorted(nvrs))

print('')
print('')
print('')
print('----------------------')
print("Build names in errata:")
print('----------------------')
print_stuff(sorted(names))

