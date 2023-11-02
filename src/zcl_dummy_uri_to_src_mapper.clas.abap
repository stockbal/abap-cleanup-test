"! <p class="shorttext synchronized">Maps URI to program/include</p>
CLASS zcl_dummy_uri_to_src_mapper DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_dummy_uri_to_src_mapper.

    CLASS-METHODS create
      RETURNING
        VALUE(result) TYPE REF TO zif_dummy_uri_to_src_mapper.
ENDCLASS.


CLASS zcl_dummy_uri_to_src_mapper IMPLEMENTATION.
  METHOD create.
    result = NEW zcl_dummy_uri_to_src_mapper( ).
  ENDMETHOD.

  METHOD zif_dummy_uri_to_src_mapper~map_adt_uri_to_src.
    DATA(uri_mapper) = lcl_uri_mapper_factory=>get_uri_mapper( uri ).
    IF uri_mapper IS INITIAL.
      RAISE EXCEPTION TYPE zcx_dummy_exception
        EXPORTING text = |URI does not conform to a valid source|.
    ENDIF.

    result = uri_mapper->map( ).

    IF result-main_prog IS NOT INITIAL.
      IF result-source_position IS INITIAL.
        result-source_position = zcl_dummy_adt_uri_util=>get_uri_source_start_pos( uri ).
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE zcx_dummy_exception
        EXPORTING text = |Main program could not be determined from URI|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
