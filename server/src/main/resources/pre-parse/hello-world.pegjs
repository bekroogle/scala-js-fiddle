/*
 * This grammar parses a single simple case of 
 * acceptible Scala.js Fiddle input. 
 *
 * For Example:
 * 
 * @JSExport
 * object ScalaJSExample {
 *
 *   @JSExport
 *   def main(): Unit = {
 *     println("test")
 *   }
 * }
 *
 */

/* Starting rule */
start
  = error { return "invalid"; }
  / object_block { return "valid";}
  

error
  = !object_block .*
  
/* Top level object block */
object_block
  = js_export obj_decl main_def_block close_brace { return "valid";}

/* object declaration* * * * * * * * *
 *   example:                        *
 *     object ScalaJSExample {       *
 * * * * * * * * * * * * * * * * * * */
obj_decl "object declaration header"
  = __ 'object' __ id __ '{' __ nl

/* JSExport annotation *
 *   example: 
 *     @JSExport       */
js_export
  = __ '@JSExport' __ nl

/* main function definition block */
main_def_block "definition of main"
  = js_export def_main print_stmt+ close_brace

/* definiton of main function */
def_main
  = __ 'def' __ 'main()' __ ':' __ 'Unit' __ '=' __ '{' __ nl

print_stmt
  = __ 'println(' __ string __ ')' __ nl

close_brace
  = __ '}' __ nl

/* Whitespace: one or more spaces|tabs */
__ "whitespace"
  = [ \t]*

/* Newline: zero or more */
nl "newline"
  = (__[\n]__)*

/* String literal: any characters enlosed by single or double quotese
    example:
      "Hello, world!"
      'Goodbye, cruel world!' */
string
  = ['] [^']* [']
  / ["] [^"]* ["]

/* Identifier: Any letter followed by a string of letters and/or numbers
    example: 
      myVariable
      myVariable2 */
id
  = [A-Za-z][A-Za-z0-9]*