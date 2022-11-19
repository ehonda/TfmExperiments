ARG dotnetVersion=7.0
FROM mcr.microsoft.com/dotnet/sdk:${dotnetVersion}-alpine

ARG dotnetVersion
ENV dotnetVersion=$dotnetVersion
WORKDIR /app
COPY . .
RUN #dotnet restore
RUN dotnet build -c Release -f net$dotnetVersion

#ENTRYPOINT ["cat", "TfmExperiments/obj/project.assets.json"]
#ENTRYPOINT exec dotnet run -c Release -f net${dotnetVersion} --project TfmExperiments/TfmExperiments.csproj
ENTRYPOINT exec dotnet run -c Release -f net6.0 --project TfmExperiments/TfmExperiments.csproj
#ENTRYPOINT [ "/bin/sh", "-c", \
#    "dotnet", \
#    "run", \
#    "-c", "Release", \
#    "-f", "net$dotnetVersion", \
#    "--project", "TfmExperiments/TfmExperiments.csproj"]
