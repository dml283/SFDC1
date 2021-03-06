global class OrderBy implements Soqlable{

    global String field {get;set;}
    global Boolean ascending {get;set;}
    global Boolean descending {get{return !ascending;}}
    global Boolean nullsFirst {get;set;}
    global Boolean nullsLast {get{return !nullsFirst;}}
    private Boolean sortSet = false;
    private Boolean nullsSet = false;
	
    global OrderBy(String field){
        if(StringUtils.isBlank(field)){
        	throw new IllegalArgumentException('field is empty');
        }
        this.field = field;
        this.ascending();
        this.sortSet = false;
    }
    
    global OrderBy ascending (){ return setAscending(true); }
    global OrderBy descending(){ return setAscending(false);}
    global OrderBy nullsFirst(){ return setNullsFirst(true);}
    global OrderBy nullsLast (){ return setNullsFirst(false);}
    
    private OrderBy setAscending(Boolean ascending){
        this.ascending = ascending;
        this.sortSet = true;
        if(!this.nullsSet){
        	this.nullsFirst = this.descending;
        }
        return this;
    }
    
    private OrderBy setNullsFirst(Boolean nullsFirst){
        this.nullsFirst = nullsFirst;
        this.nullsSet = true;
        return this;
    }

    global String toSoql(){ return this.toSoql(null); }
    
    global String toSoql(SoqlOptions options){
        if(options == null){
            options = SoqlOptions.DEFAULT_OPTIONS;
        }
        return this.field 
           + (sortSet ? (ascending ? ' ASC' : ' DESC'): '')
           + (nullsSet ? (nullsFirst ? ' NULLS FIRST' : ' NULLS LAST') : '')
        ;
    }
    

}