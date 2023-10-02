"! <p class="shorttext synchronized">Maps URI to program/include</p>
INTERFACE zif_dummy_uri_to_src_mapper
  PUBLIC.

  "! <p class="shorttext synchronized">Maps an ADT URI to the include/program of its origin</p>
  METHODS map_adt_uri_to_src
    IMPORTING
      uri           TYPE string
    RETURNING
      VALUE(result) TYPE zif_dummy_ty_global=>ty_adt_uri_info
    RAISING
      zcx_dummy_exception.

ENDINTERFACE.
