/*
    ASL script for Silent Hill 1
    - GitHub: https://github.com/BoredOfSpeedruns/Silent-Hill-1-Autosplitter
	emu-help-v2 created by Jujstme
	- GitHub: https://github.com/Jujstme
*/

state("LiveSplit") {}

startup {
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");
	
	vars.bitCheck = new Func<byte, int, bool>((byte val, int b) => (val & (1 << b)) != 0);

	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
		emu.MakeString("UGamecode", 10, 0x009244);		//SLUS-00707
		emu.Make<int>("U_IGT", 0xBCC84);
		return true;
    });
}

update
{
	current.IGT = current.U_IGT;
}

gameTime {
	return TimeSpan.FromSeconds(current.U_IGT / 4096f);
}