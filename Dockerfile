FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
RUN apt-get update -yq 
RUN apt-get install curl gnupg -yq 
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

WORKDIR /source
COPY DotnetTemplate.Web/*.csproj ./DotnetTemplate.Web/
RUN dotnet restore DotnetTemplate.Web

FROM build AS publish
COPY DotnetTemplate.Web/. ./DotnetTemplate.Web/
WORKDIR /source/DotnetTemplate.Web
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]