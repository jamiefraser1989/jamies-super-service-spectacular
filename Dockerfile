# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app

# Copy sln & csproj files
COPY *.sln .
COPY src/SuperService.csproj ./src/
COPY test/SuperService.UnitTests.csproj ./test/

# Restore dependencies
RUN dotnet restore

# Copy full solution
COPY . .
RUN dotnet build

# Unit test build
FROM build-env AS test
WORKDIR /app/test
RUN dotnet test --logger:trx

# Publish build
FROM build-env AS publish
WORKDIR /app/src/
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=publish /app/src/out ./
ENTRYPOINT ["dotnet", "SuperService.dll"]