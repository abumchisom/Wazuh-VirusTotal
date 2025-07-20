# Wazuh-VirusTotal

This outlines how I set up Advanced File Monitoring and actions using the built-in File Integrity Module on Wazuh and its integration with VirusTotal


## File Integrity Module (FIM)
FIM is a feature on Wazuh that monitors selected directories for changes made to files in those directories. These changes include: file creation, deletion, modification of contents, and file movements in and out of the directory. 

There are two major ways to set up FIM on Wazuh; the first is via the ossec.conf file on the Wazuh agent. The second, which happens to be the best, is via the agent.conf file on the dashboard group.

The first method is via OSSEC.conf file. This can be accessed on Linux via `sudo nano /var/ossec/etc/ossec.conf` and on Windows via `cd "C:\Users\User\Program Files (x86)\ossec-agent"`, then `notepad ossec.conf`

The second method is the best for two reasons:
- Wazuh treats configurations made at the group level(agents are placed into groups, i.e, default, WindowsHosts) with a higher priority than configurations at the ossec.conf on the endpoint. because of this,  dashboard-level configuration will override local configuration, in case users of the endpoint do something else to their OSSEC.conf file.
- In enterprise environments where you may be monitoring many devices from a remote location, you can't possibly access all connected devices physically to edit the OSSEC.conf file. This is why grouped configuration on the dashboard is more important.

To set up FIM on Wazuh, check the [OSSEC.conf](ossec.conf) file uploaded to this project (This assumes that your Windows and Linux agents are merged in one group, and that you are using the dashboard method:



**Note: In Wazuh, when a file is moved out of a monitored directory, it is logged as deleted, and when a file is moved into a directory, it is logged as created.**


## VirusTotal

Once we have set up our FIM on our agents, and confirmed that it is working as seen on the [Checks.md](checks.md), proceed to your Wazuh manager/server.

Open its [ossec.conf](manager.sh) (This is different from what is found on endpoints' OSSEC.conf. I tagged it manager.sh in this project) `sudo nano /var/ossec/etc/ossec.conf`

At the end of the file, paste the contents of manager.sh.

Before then, you must have gotten your VirusTotal API key from VirusTotal. Add that at the API placeholder in manager.sh

Save with CTRL + O, then CTRL + X.
Restart the Wazuh manager with `sudo systemctl restart wazuh-manager`
Verify that all is running fine with `sudo systemctl status wazuh-manager`


What this does is that when a file is spotted by Wazuh agents, its hash is sent over to VirusTotal, and if found to be malicious, it is automatically deleted.
You can test that it works by finding the file to download in the second section of the [Checks.md](checks.md).
