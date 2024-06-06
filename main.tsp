import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

/**
 * This is a sample server Petstore server.
 */
@service({
  title: "Pet Store Service",
})
@server(
  "{url}",
  "Single server endpoint",
  {
    url?: string = "https://petstore.swagger.io",
  }
)
@versioned(Versions)
namespace PetStore;

enum Versions {
  v1,
}

model Pet {
  @minLength(100)
  name: string;

  @minValue(0)
  @maxValue(100)
  age: int32;

  kind: "dog" | "cat" | "fish";
}

@route("/pets")
namespace Pets {
  op list(@query skip: int32, @query top: int32): {
    @statusCode statusCode: 200;
    @body pets: Pet[];
  };
  op read(@path petId: int32, @header ifMatch?: string): {
    @statusCode statusCode: 200;
    @header eTag: string;
    @body pet: Pet;
  } | {
    @statusCode statusCode: 404;
  };
  op create(@body pet: Pet): {
    @statusCode statusCode: 204;
  };
}

@route("/pets/{petId}/toys")
namespace PetToys {
  model Toy {
    name: string;
  }
  op list(@path petId: int32): Toy[];
}

model CommonParameters {
  @path
  @segment("tenants")
  tenantId: string;

  @path
  @segment("users")
  userName: string;
}

model User {
  name: string;
}
@error
model Error {
  message: string;
}

// Automatic route generation
@autoRoute
interface UserOperations {
  @get
  getUser(...CommonParameters): User | Error;

  @put
  updateUser(...CommonParameters, user: User): User | Error;
}
