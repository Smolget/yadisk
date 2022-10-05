# frozen_string_literal: true

require "addressable/uri"
require "faraday"
require "faraday_middleware"
require "yadisk/version"

module Yadisk
  autoload :Client, "yadisk/client"
  autoload :Object, "yadisk/object"
  autoload :Error,  "yadisk/error"
  autoload :Rest,   "yadisk/rest"

  autoload :Collection, "yadisk/collection"

  autoload :Operation, "yadisk/objects/operation"
  autoload :OperationRest, "yadisk/resources/operation"

  autoload :PublicRest, "yadisk/resources/public"
  autoload :PublicResource, "yadisk/objects/public"

  autoload :Trash, "yadisk/objects/trash"
  autoload :TrashResource, "yadisk/objects/trash"
  autoload :TrashRest, "yadisk/resources/trash"

  autoload :Disk, "yadisk/objects/disk"
  autoload :DiskRest, "yadisk/resources/disk"

  autoload :Link, "yadisk/objects/link"
  autoload :Resource, "yadisk/objects/resource"
  autoload :ResourceUploadLink, "yadisk/objects/resource"
  autoload :LastUploadedResourceList, "yadisk/objects/resource"

  autoload :Operation, "yadisk/objects/operation"
end
