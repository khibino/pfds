
include c_basic.gmk


include ocaml_basic.gmk
ocaml_extra_load_path = -I .

subdirs = pStack pSet pHeap

basic_cmis = pMap.cmi pElem.cmi
cmis = pStack/type.cmi pSet/type.cmi $(basic_cmis)
byte_objs = pStack.cmo pSet.cmo pHeap.cmo
nat_objs  = pStack.cmx pSet.cmx pHeap.cmx

all: $(basic_cmis) $(byte_objs) $(nat_objs)

rebuild: clean all

pStack.cmo: pStack/type.cmi pStack/aList.cmo pStack/custom.cmo
	$(ocamlc) -pack $^ -o $@

pStack.cmx: pStack/type.cmi pStack/aList.cmx pStack/custom.cmx
	$(ocamlopt) -pack $^ -o $@

pSet.cmo: pSet/type.cmi pSet/unbalanced.cmo pSet/redBlack.cmo
	$(ocamlc) -pack $^ -o $@

pSet.cmx: pSet/type.cmi pSet/unbalanced.cmx pSet/redBlack.cmx
	$(ocamlopt) -pack $^ -o $@

pHeap.cmo: pHeap/type.cmi pHeap/leftist.cmo pHeap/binomial.cmo
	$(ocamlc) -pack $^ -o $@

pHeap.cmx: pHeap/type.cmi pHeap/leftist.cmx pHeap/binomial.cmx
	$(ocamlopt) -pack $^ -o $@

test: all
	find utests -name '*.ml' | while read tml ; do \
		top=$(shell pwd); \
		dir=$$(dirname $$tml); \
		name=$$(basename $$tml .ml); \
		src=$${name}.ml; \
		bobj=$${name}.cmo; \
		(\
		set -x ; \
		cd $$dir && \
		ocamlc -I $$top -c $$src && \
		ocaml -I $$top pSet.cmo $$bobj \
		); \
	done

clean:
	$(RM) *.cmo *.cmx *.o
	$(RM) *.cmi
	for subdir in $(subdirs) ; do \
		$(RM) $${subdir}/*.cmo $${subdir}/*.cmx $${subdir}/*.o $${subdir}/*.cmi ; \
	done
