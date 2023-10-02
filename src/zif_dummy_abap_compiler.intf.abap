"! <p class="shorttext synchronized">Wrapper around ABAP Compiler</p>
INTERFACE zif_dummy_abap_compiler
  PUBLIC.

  "! <p class="shorttext synchronized">Retrieves ABAP element src info by begin/end refs</p>
  METHODS get_src_by_start_end_refs
    IMPORTING
      full_name     TYPE string
    RETURNING
      VALUE(result) TYPE zif_dummy_ty_global=>ty_ae_src_info.

  "! <p class="shorttext synchronized">Retrieves refs for single fullname</p>
  METHODS get_refs_by_fullname
    IMPORTING
      full_name     TYPE string
      grade         TYPE scr_grade OPTIONAL
    RETURNING
      VALUE(result) TYPE scr_refs.

  "! <p class="shorttext synchronized">Retrieve refs for list of fullnames</p>
  METHODS get_refs_by_fullnames
    IMPORTING
      full_names    TYPE scr_names_grades
    RETURNING
      VALUE(result) TYPE scr_refs.

  "! <p class="shorttext synchronized">Check a Full Name (Existence of Object)</p>
  METHODS get_symbol_entry
    IMPORTING
      full_name     TYPE string
    RETURNING
      VALUE(result) TYPE REF TO cl_abap_comp_symbol.

  "! <p class="shorttext synchronized">Retrieve references in given include and range</p>
  METHODS get_refs_in_range
    IMPORTING
      !include      TYPE progname
      start_line    TYPE i
      end_line      TYPE i
    RETURNING
      VALUE(result) TYPE scr_names_tags_grades.

  "! <p class="shorttext synchronized">Retrieves direct references for full name(s)</p>
  METHODS get_direct_references
    IMPORTING
      full_name     TYPE string       OPTIONAL
      full_names    TYPE string_table OPTIONAL
      start_line    TYPE i
      end_line      TYPE i
    RETURNING
      VALUE(result) TYPE scr_refs.

  "! <p class="shorttext synchronized">Retrieve fullname in include for the given position</p>
  METHODS get_full_name_for_position
    IMPORTING
      !include      TYPE progname
      !line         TYPE i
      !column       TYPE i
    RETURNING
      VALUE(result) TYPE  scr_name_tag_grade.

ENDINTERFACE.
