"! <p class="shorttext synchronized">Method info reader</p>
INTERFACE zif_dummy_method_info_reader
  PUBLIC.

  "! <p class="shorttext synchronized">Reads method properties</p>
  METHODS read_properties
    IMPORTING
      full_name     TYPE string
    RETURNING
      VALUE(result) TYPE zif_dummy_ty_global=>ty_method_properties
    RAISING
      zcx_dummy_exception.
ENDINTERFACE.
