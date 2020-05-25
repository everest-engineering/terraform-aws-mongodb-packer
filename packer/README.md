# Packer AMI

Module for building the custom AMI images for mongodb on ubuntu platforms.

### Tech
* [Packer] - Packer is a free and open source tool for creating golden images for multiple platforms from a single source configuration.
* [Shell] - A shell script to provision mongo distribution on AMI image.

### Installation
Install packer using below documentation

```https://www.packer.io/intro/getting-started/```

## Supported Plaforms and Mongo version

To build custom AMI images, we need underlying vanilla base image to provison mongodb and the specific version of mongodb.

Currently `Ubuntu 18.04` and `Ubuntu 16.04` platforms of type `EBS-backed` are supported to be as underlying base image.

Only `Mongo 4.2` and `Mongo 4.0` Community versions are supported.

| Platform      | 4.2 Community     | 4.0 Community      |
| ------------- | ----------------- | -------------------|
| Ubuntu 18.04  | :heavy_check_mark:| :heavy_check_mark: |
| Ubuntu 16.04  | :heavy_check_mark:|      :x:           |


### Configuration

You should pass custom configuration to ``template.json`` to build the image.

* `` region: ``  Name of the aws region in which it will upload the custom images. And also provided `` base_ami_id`` should be exist in this region. ```Ex: ap-south-1```
* `` base_ami_id: `` Base ami id on which it will provision the mongo db. ```Ex: ami-0fd7e4b8e94538bef```
* `` mongo_version: `` Specify the version of mongo db. As part of provisiong, it will install the latest stable version of this release.  ``` Ex: 4.2 (Don't give the specific version like 4.2.3)```
* `` ami_name: `` Name for newly created mongo AMI. ```Ex: terraform-mongo-ami```

### To build image

Before we take this template and build an image from it, let's validate the template by running 

```sh 
$ cd packer
$ packer validate template.json
```
Before you build the image on cloud platforms, you need to setup authentication for aws. To setup authentication follow below documentation
   
   ``` https://www.packer.io/docs/builders/amazon/#authentication ```

Building custom images on AWS:
```sh
$ packer build -var region=ap-south-1 -var ami_name=terraform-mongo-ami -var mongo_version=4.2 -var base_ami_id=ami-0fd7e4b8e94538bef template.json
```
Once you have done above steps, it will produce the AMI image with below name ```terraform-mongo-ami ``` in specified region.


### Build Images in CI/CD

To automate the process of building images in CI/CD you can follow the below documentation:

```https://www.packer.io/guides/packer-on-cicd/build-image-in-cicd/```

You can import the ```Jenkinsfile``` to automate the CI/CD using jenkins.

### Deployment

As packer is tool for creating custom images, they don't have any deployment options. You can use your own deployment options using CI/CD.

Refer the below documentation to upload your artifacts to cloud:

``` https://www.packer.io/docs/templates/post-processors/ ```
