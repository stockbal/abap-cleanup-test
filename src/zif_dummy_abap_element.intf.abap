"! <p class="shorttext synchronized">Call hierarchy for a method/form/function</p>
INTERFACE zif_dummy_abap_element
  PUBLIC.

  TYPES ty_ref_tab TYPE STANDARD TABLE OF REF TO zif_dummy_abap_element WITH EMPTY KEY.

  DATA element_info TYPE zif_dummy_ty_global=>ty_abap_element READ-ONLY.

  "! <p class="shorttext synchronized">Returns call position URI</p>
  METHODS get_call_position_uri
    IMPORTING
      !position     TYPE zif_dummy_ty_global=>ty_source_position OPTIONAL
    RETURNING
      VALUE(result) TYPE string.

  "! <p class="shorttext synchronized">Retrieves called ABAP elements</p>
  METHODS get_called_elements
    IMPORTING
      settings      TYPE zif_dummy_ty_global=>ty_hierarchy_api_settings OPTIONAL
      force_reset   TYPE abap_bool                                      OPTIONAL
    RETURNING
      VALUE(result) TYPE ty_ref_tab.

  "! <p class="shorttext synchronized">Updates the include where the element occurs</p>
  METHODS set_include
    IMPORTING
      !value TYPE progname.
ENDINTERFACE.
