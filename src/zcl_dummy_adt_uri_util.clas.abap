"! <p class="shorttext synchronized">Utility for ADT URIs</p>
CLASS zcl_dummy_adt_uri_util DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! <p class="shorttext synchronized">Retrieves Start position from URI</p>
    CLASS-METHODS get_uri_source_start_pos
      IMPORTING
        uri           TYPE string
      RETURNING
        VALUE(result) TYPE zif_dummy_ty_global=>ty_source_position.
ENDCLASS.


CLASS zcl_dummy_adt_uri_util IMPLEMENTATION.
  METHOD get_uri_source_start_pos.
    FIND REGEX '.*#start=(\d+),?(\d+)?.*' IN uri
         RESULTS DATA(match).

    IF lines( match-submatches ) <> 2.
      RETURN.
    ENDIF.

    DATA(line_match) = match-submatches[ 1 ].
    DATA(column_match) = match-submatches[ 2 ].

    IF line_match-offset > 0.
      DATA(offset) = line_match-offset.
      DATA(length) = line_match-length.
      result-line = uri+offset(length).
    ENDIF.

    IF column_match-offset > 0.
      offset = column_match-offset.
      length = column_match-length.
      result-column = uri+offset(length).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
