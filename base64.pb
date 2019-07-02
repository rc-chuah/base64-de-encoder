DataSection
    Licensea:
      IncludeBinary "LICENSE"
    Licenseb:
EndDataSection

Global prog$ = GetFilePart(ProgramFilename())

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
  
  Global d$ = "/d"
  Global e$ = "/e"
  Global h$ = "/h"
  Global l$ = "/l"
  Global v$ = "/v"
    
CompilerElse
  
  Global d$ = "-d"
  Global e$ = "-e"
  Global h$ = "-h"
  Global l$ = "-l"
  Global v$ = "-v"
  
CompilerEndIf

Procedure ErrorHandler()
  
  ec = ErrorCode()
  
If OpenConsole()
  
  Print(ErrorMessage(ec))
  
  CloseConsole()
  
EndIf

  End ec

EndProcedure
Procedure Version()

If OpenConsole()
  
  PrintN("")
  PrintN(" Base64 De-/Encoder v2.0")
  PrintN("")
  PrintN(" Last updated: 2019-07-02")
  PrintN("")
  PrintN(" Available at: ZeroNet")
  PrintN("               http://127.0.0.1:43110/17SWVnHoujG92yYGSZvCzPgZEpGVfRF8wi")
  PrintN("              ")
  PrintN("               Github")
  PrintN("               https://github.com/99fk/base64-de-encoder")
  
  PrintN("")
  CloseConsole()
    
EndIf

  End

EndProcedure
Procedure ShowHelp()

If OpenConsole()
  
  PrintN("")
  PrintN("Base64 De-/Encoder - Decode and Encode using the Base64 algorithm.") 
  PrintN("")
  PrintN("Call:  "+prog$+" [option]") 
  PrintN("")
  PrintN("Options:")
  PrintN("          " + d$ + "         Decode")
  PrintN("          " + e$ + "         Encode")
  PrintN("          " + h$ + "         Show this help message")
  PrintN("          " + l$ + "         Show license")
  PrintN("          " + v$ + "         Show version information")
  
  PrintN("")
  
  PrintN("Examples: "+prog$+" " + e$ + " < file.txt > encoded.base64")
  PrintN("          "+prog$+" " + d$ + " < encoded.base64 > file.txt")
    
  PrintN("")
  
  PrintN("by Fatih Kodak")
  PrintN("http://127.0.0.1:43110/17SWVnHoujG92yYGSZvCzPgZEpGVfRF8wi")

  CloseConsole()
  
EndIf
  
  End

EndProcedure
Procedure Help()
  
  If OpenConsole()
    
    PrintN("Type '"+ prog$ + " " + h$ + "' for help")
    CloseConsole()
    
  EndIf

  End
  
EndProcedure
Procedure GetData()
  
If OpenConsole()
    
  s=10000
  *mem = AllocateMemory(s)
  rs=1
  
    While rs>0
  
      rs = ReadConsoleData( *mem + total, s)
    
      total + rs
    
      *mem = ReAllocateMemory( *mem , total + s )
   
    Wend

    
  CloseConsole()
  *mem = ReAllocateMemory( *mem , total )
    
  ProcedureReturn *mem
  
EndIf
  
EndProcedure
Procedure Decode(*mem)
  
  total=MemorySize(*mem)
  *dst=AllocateMemory(total)
  
  size=Base64DecoderBuffer(*mem, total, *dst, total)
  
If OpenConsole()
  
  WriteConsoleData(*dst,size)
  CloseConsole()
  
EndIf

  End
  
EndProcedure
Procedure Encode(*mem)
  
  total=MemorySize(*mem)
  
  dstsize.q = (total * 5) / 3 + 1000
  
  *dst=AllocateMemory(dstsize)
    
  size=Base64EncoderBuffer(*mem, total, *dst, dstsize)
  
  
If OpenConsole()
  
  WriteConsoleData(*dst,size)
  CloseConsole()
  
EndIf

  End

EndProcedure
Procedure Main()
      
If CountProgramParameters() < 1
  
  Help()
  
EndIf
  
Select ProgramParameter(0)
    
  Case h$
      ShowHelp()
    
  Case v$
    Version()
    
  Case d$
    *mem = GetData()
    Decode(*mem)
    
  Case e$
    
    *mem = GetData()
    Encode(*mem)
    
  Case l$
  
    If OpenConsole()
  
      PrintN( PeekS(?Licensea, ?Licenseb-?Licensea, #PB_UTF8) )
      CloseConsole()
  
    EndIf

    End
    
   Default
     
     Help()
     
EndSelect
    
EndProcedure

OnErrorCall(@ErrorHandler())
Main()
; IDE Options = PureBasic 5.70 LTS (Linux - x64)
; ExecutableFormat = Console
; Folding = A5
; EnableXP
; Executable = base64
; CPU = 1