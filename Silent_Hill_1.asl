/*
	ASL script for Silent Hill 1
	- GitHub: https://github.com/roxasunbanned/Silent-Hill-1-Autosplitter
	emu-help-v2 created by Jujstme
	- GitHub: https://github.com/Jujstme
*/

state("LiveSplit") {}

startup {
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");
	
	vars.bitCheck = new Func<byte, int, bool>((byte val, int b) => (val & (1 << b)) != 0);

	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
	{
		emu.MakeString("Gamecode", 11, 0x9244);		//SLUS-00707 / SLPM-86192
		emu.Make<int>("U_IGT", 0xBCC84);
		emu.Make<int>("J_IGT", 0xBF1B4);
		return true;
	});
}

update
{
	if(current.Gamecode == "SLUS_007.07") {
		current.IGT = current.U_IGT;
	} else {
		current.IGT = current.J_IGT;
	}
}

gameTime {
	return TimeSpan.FromSeconds(current.IGT / 4096f);
}
