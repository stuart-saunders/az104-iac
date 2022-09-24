
## Run Ansible in Docker container
Build the image
`docker build . -t ansible`

Run a container, and mount current folder
`docker run -it --rm --volume "${PWD}:/ansible" --workdir /ansible ansible`

```
docker run -it --rm --volume "$(pwd):/ansible" --workdir /ansible \
--env "TENANT_ID=<Tenant Id>" \
--env "SUBSCRIPTION_ID=<Subscription Id>" \
--env "CLIENT_ID=<Client Id>" \
--env "CLIENT_SECRET=<Client Secret>" \
ansible
```

Attach to running container
`docker attach <containerId>`

Run the playbook
`ansible-playbook main.yml -i inventory.yml`