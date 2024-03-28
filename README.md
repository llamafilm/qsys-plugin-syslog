# Syslog Sender Plugin

This plugin sends all Qsys Event Log messages to a remote syslog server using UDP port 514, based on RFC 5424.  It also replicates the output pins of a standard Event Log component.

Standard syslog fields:
- Hostname: The name of the Core Status component (else fallback to `unknown-qsys`)
- Identifier: `qsys`
- Facility: `14`
- Level: either `informational`, `error`, or `warning`

Status will be `OK` as long as you enter a valid IP or DNS name.  There is no validation that the UDP port is actually open and receiving data.

Plugin is based on the [BasicPluginFramework](https://bitbucket.org/qsc-communities/basicpluginframework/src/main/) from QSC and includes the VS Code submodule for easy compiling.
