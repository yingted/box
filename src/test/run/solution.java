class Solution{//must be called solution
	public static void main(String[]args){
		for(int i=0;i<100;++i)
			new java.lang.Thread(){
				@Override public void run(){
					//Inner class
				}
			}.start();
		System.out.println(42);
	}
}
