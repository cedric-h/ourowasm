(; // vim: sw=2 ts=2 expandtab smartindent
;)
(module
  (memory (;0;) 2)
  (export "memory" (memory 0))

  (data
    (;0;)
    (i32.const 1024)

"\00" "\61" "\73" "\6d"
"\01" "\00" "\00" "\00"
"\01" "\05"
  "\01" "\60" "\01" "\7f" "\00"
"\03" "\02"
  "\01" "\00"
"\04" "\05"
  "\01" "\70" "\01" "\01" "\01"
"\05" "\03"
  "\01" "\00" "\02"
"\07" "\11"
  "\02" "\06"
    "\6d" "\65" "\6d" "\6f" "\72" "\79"
    "\02" "\00" "\04"
    "\65" "\78" "\65" "\63"
    "\00" "\00"

"\0a" "\54" (; Code, nbytes ;)
  "\01" (; 1 func ;)
  "\52" (; func nbytes ;)
  "\01" (; type index ;)
"\01" "\7f" (; 1st local = i32 ;)
"\03" "\40" (; loop ;)
"\20" "\00" (; load param ;)
"\20" "\01" (; load first local ;)
"\6a"       (; add ;)
"\20" "\01"       (; load first local ;)
"\41" "\80" "\08" (; i32.const 1024 ;)
"\6a"             (; add ;)
"\2d" "\00" "\00" (;            1024[i] ;)
"\3a" "\00" "\00" (; param[i] = ^ ;)
"\20" "\01" (;               load first local ;)
"\41" "\01" (;               i32.const 1 ;)
"\6a"       (;               add ;)
"\21" "\01" (; first local = ^ ;)
"\20" "\01" (; load first local again ;)
"\41" "\93" "\01" (; i32.const 147 ;)
"\47"             (; i32.ne ;)
"\0d" "\00"       (; br_if 0 ;)
"\0b"  (; end loop ;)
"\41" "\00" (;               i32.const 0 ;)
"\21" "\01" (; first local = ^ ;)

(; copy paste of first loop, one exception ;)
"\03" "\40" (; loop ;)
"\20" "\00" (; load param ;)
"\20" "\01" (; load first local ;)
"\6a"       (; add ;)
(; NOT IN FIRST LOOP ;) "\41" "\93" "\01" (; i32.const 147 ;)
(; NOT IN FIRST LOOP ;) "\6a"             (; add ;)
"\20" "\01"       (; load first local ;)
"\41" "\80" "\08" (; i32.const 1024 ;)
"\6a"             (; add ;)
"\2d" "\00" "\00" (;            1024[i] ;)
"\3a" "\00" "\00" (; param[i] = ^ ;)
"\20" "\01" (;               load first local ;)
"\41" "\01" (;               i32.const 1 ;)
"\6a"       (;               add ;)
"\21" "\01" (; first local = ^ ;)
"\20" "\01" (; load first local again ;)
"\41" "\93" "\01" (; i32.const 147 ;)
"\47"             (; i32.ne ;)
"\0d" "\00"       (; br_if 0 ;)
"\0b"  (; end loop ;)
"\0b" (; end func ;)

"\0b" "\9b" "\01" (; Data, 147 nbytes ;)
"\01" (; 1 data ;)
"\00" (; active ;)
  "\41" "\80" "\08" (; i32.const 1024 ;)
  "\0b"  (; end expr ;)
"\93" "\01" (; 147 bytes ;)

  )

  (table (;0;) 1 1 funcref)
  (export "exec" (func 0))
  (type (;0;) (func (param i32)))
  (func (;0;) (type 0) (param $str i32)
    (local $i i32)
    loop  ;; label = @1
      (i32.store8
        (i32.add
          (local.get $str)
          (local.get $i))
        (i32.load8_u
          (i32.add
            (local.get $i)
            (i32.const 1024)))
      )

      (local.set $i
        (i32.add
          (local.get $i)
          (i32.const 1)))

      (br_if 0
        (i32.ne
          (local.get $i)
          (i32.const 147)))
    end
    (local.set $i (i32.const 0))
    loop  ;; label = @1
      (i32.store8
        (i32.add
          (i32.add
            (i32.const 147)
            (local.get $str))
          (local.get $i))
        (i32.load8_u
          (i32.add
            (local.get $i)
            (i32.const 1024)))
      )

      (local.set $i
        (i32.add
          (local.get $i)
          (i32.const 1)))

      (br_if 0
        (i32.ne
          (local.get $i)
          (i32.const 147)))
    end
  )
)
