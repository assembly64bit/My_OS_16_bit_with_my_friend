OUTPUT_FORMAT("binary")
ENTRY(start)

SECTIONS
{
  . = 0x8000;

  .text :
  {
    *(.text)
  }

  .data :
  {
    *(.data)
  }

  .bss :
  {
    *(.bss)
  }
}

