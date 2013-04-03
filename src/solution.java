class solution{
	public static void main(String[]args){
		for(int i=0;i<100;++i)
			new java.lang.Thread().start();
		System.out.println(42);
	}
}
