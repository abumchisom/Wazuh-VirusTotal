<ossec_config>
  <!-- Other configurations like syscheck, rules, etc. -->
  <!-- The VirusTotal API block is placed at the bottom of the manager's ossec.conf for clarity and to avoid breaks. As an integration block, it is independent, and its placement isn't strict, however, it should be at the bottom so that other configs that require strict placement can be parsed properly. -->

  <!-- VirusTotal Integration -->
  <integration>
    <name>virustotal</name>
    <api_key>YOUR_VIRUSTOTAL_API_KEY</api_key>
    <group>syscheck</group>
    <alert_format>json</alert_format>
  </integration>

</ossec_config>
