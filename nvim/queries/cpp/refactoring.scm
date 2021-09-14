;; Grabs all the local variable declarations.  This is useful for scope
;; variable passing.  Which variables do we need to pass to the extracted
;; function?
(declaration) @definition.local_name


;; grabs all the arguments that are passed into the function.  Needed for
;; function extraction, 106
(parameter_declaration) @definition.function_argument

;; This is for function scope finding
(function_definition) @definition.scope
;; TODO: [2021-09-14,wruggian]: lambda functions: (declaration) (declarator.value = lambda_expression)
