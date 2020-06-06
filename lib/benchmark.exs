Benchee.run(%{
  "received_disconnect" => fn -> SshParser.parse("Received disconnect from 193.80.103.122 port 39548:11: disconnected by user") end,
  "disconnect" => fn -> SshParser.parse("Disconnected from 193.80.103.122 port 39548") end,
  "session_close" => fn -> SshParser.parse("pam_unix(sshd:session): session closed for user ubuntu") end,
  "accepted" => fn -> SshParser.parse("Accepted publickey for ubuntu from 193.80.103.122 port 45294 ssh2: RSA SHA256:/W/MiFhK3j4csjW177UY51a2CiifhjpXCcayh+u45qI") end,
})
