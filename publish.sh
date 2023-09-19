set ASPNETCORE_ENVIRONMENT=Development

echo "gerando build api..."
rm -rf publish
dotnet publish -r linux-x64 -o publish/linux-x64 -c Release
rm publish/linux-x64/*.pdb
echo "parando serviço api..."
ssh srv-deepcode "sudo /bin/systemctl stop demo-api.dotnet.service"
echo "removendo arquivos api..."
ssh srv-deepcode "rm -rf /data/apps/api/demo/*"
echo "copiando arquivos api..."
scp -r publish/linux-x64/* srv-deepcode:/data/apps/api/demo
echo "iniciando serviço api..."
ssh srv-deepcode "sudo /bin/systemctl start demo-api.dotnet.service"
