Dim Shell, lnk, newName, strIdx, FSO

Set Shell = CreateObject("WScript.Shell")

'cscript "C:\Users\barrykauhl.KCCHI_D\Documents\MyKorteFiles\Misc\RemoveAppleDouble.vbs"

'on error resume next
Set FSO = CreateObject("Scripting.FileSystemObject")


'ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Illinois"), 1
'ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Missouri"), 1
ShowSubfolders FSO.GetFolder("N:\National"), 1
'ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Oklahoma"), 3

Sub ShowSubFolders(Folder, Depth)
If Depth = 0 then
	wscript.echo Folder
end if
    If Depth >= 0 then
        For Each Subfolder in Folder.SubFolders        
        if Subfolder.Path <> "N:\National\Amazon Fresh Temp Cooler Expansion Phase 2 NoVa Springfield VA_21026" _
	and Subfolder.Path <> "N:\National\Cloud Co Health Center - Hospital and Clinic_20948" _
	and Subfolder.Path <> "N:\National\NAVFAC P403 Reconditioning Ctr Barracks Reno Parris Island SC_21028" _
	and Subfolder.Path <> "N:\National\Four Seasons Resort Renov Vail CO_21055" _
	and Subfolder.Path <> "N:\National\Jack Links Jerky Mfg Fac Mankato MN_21057" _
	and Subfolder.Path <> "N:\National\NAVFAC Branch Health Clinic Bldg 1028 Kings Bay GA_20899" _
	and Subfolder.Path <> "N:\National\DHL Johnson&Johnson BTS DC Toronto ON_21029" _
	and Subfolder.Path <> "N:\National\Wyoming Museum of Military Vehicles Dubois WY_21052" _
	and Subfolder.Path <> "N:\National\COE TASS Training Center Fort Lee VA_20893" _
	and Subfolder.Path <> "N:\National\VA Outpatient Clinic New Port Richey FL_21012" _
	and Subfolder.Path <> "N:\National\Logan County Hospital Surgical Suite Oakley KS_21033" _
	and Subfolder.Path <> "N:\National\Plastikon Healthcare Mfg Lawrence KS_21048" _
	and Subfolder.Path <> "N:\National\COE FY14 240 Person Dorm Nellis AFB_90612 69002" _
	and Subfolder.Path <> "N:\National\COE F35 Maint Hangar Luke AFB AZ_20891" _
	and Subfolder.Path <> "N:\National\Newark Gateway Blvd Warehouse Newark CA_21059" _
	and Subfolder.Path <> "N:\National\VA Outpatient CLinic Bakersfield CA_21043" _
	and Subfolder.Path <> "N:\National\DHL Prestige Products Distribution Center_21031" _
	and Subfolder.Path <> "N:\National\COE ARC Proving Ground Aberdeen MD_20890" _	
	and Subfolder.Path <> "N:\National\MWR Millington Family Recreation Center Millington TN_21002" _
	and Subfolder.Path <> "N:\National\Montezuma Creek Health Center Montezuma UT_20959" _
	and Subfolder.Path <> "N:\National\Hitachi 2014 Bldg Expansion_20795" _
	and Subfolder.Path <> "N:\National\MWR East Beach Lodge Ft Rucker AL_21013" _
	and Subfolder.Path <> "N:\National\UNHS Blanding Health Center Blanding UT_21047" _
	and Subfolder.Path <> "N:\National\SDA Outpatient Clinic Lake Charles_20905" _
	and Subfolder.Path <> "N:\National\Amazon Fresh Temp Cooler Expansion NoVA Springfield VA_20996" _
	and Subfolder.Path <> "N:\National\MWR Navy Gateway Inn & Suites Central Fac Jacksonville FL_21042" _
	and Subfolder.Path <> "N:\National\Concho County Replacement Hosp Eden_TX_21038" _
	and Subfolder.Path <> "N:\National\NAVFAC Whidbey Island P239 EA 18G Facility_20835" _
	and Subfolder.Path <> "N:\National\USPS P&DC Portland OR_20943" _
	and Subfolder.Path <> "N:\National\Moore Cty Hosp Add & Renov Prog Mgr Dumas TX_20989" _
	and Subfolder.Path <> "N:\National\Amazon Fresh Atlanta GA_20935" _
	and Subfolder.Path <> "N:\National\NAVFAC Whidbey Island P251b Hangar_20838" _
	and Subfolder.Path <> "N:\National\Moore County Hospital Dumas TX_20855" _
	and Subfolder.Path <> "N:\National\Val Verde Hospital Interior Reno_Del Rio TX_20946" _
	and Subfolder.Path <> "N:\National\Tri Star Co Spec Cross Dock DC Harrisburg PA_21053" _
	and Subfolder.Path <> "N:\National\Monroe-Gregg School Dist Renov Monrovia IN_20975" _
	and Subfolder.Path <> "N:\National\MWR Club Catering Center NAB Coronado CA_21041" _
	and Subfolder.Path <> "N:\National\Plains Memorial Hosp New Senior Living Fac_Dimmit_TX_20973" _
	and Subfolder.Path <> "N:\National\NAVFAC Whidbey Island P251a Ops Train Facility_20827" _
	and Subfolder.Path <> "N:\National\Project Horizon DC Ocala FL_20971" _
	then
	
	if Subfolder.Path <> "N:\National\Marley Spoon Warehouse Buildout Grand Prairie TX_21051" _
	and Subfolder.Path <> "N:\National\Clancy Route 22 Warehouse Patterson NY_21037" _
	and Subfolder.Path <> "N:\National\COE ARC Bowie Maryland_20848_70001" _
	and Subfolder.Path <> "N:\National\COE FY17 Hangar 8 Renov Corpus Christi TX_21027" _
	and Subfolder.Path <> "N:\National\New Frontier Wind O & M Bldg McHenry Co ND_21054" _
	and Subfolder.Path <> "N:\National\Suncap Technimark Latrobe PA_21045" _
	and Subfolder.Path <> "N:\National\COE FY15 Squad Ops FY16 Op Training Cannon AFB NM_21006" _
	and Subfolder.Path <> "N:\National\COE DOE UPF Constr Support Bldg Oak Ridge TN_20925" _
	and Subfolder.Path <> "N:\National\DHL BTS Bucks County PA_21058" _
	and Subfolder.Path <> "N:\National\Mitchell Co Hosp Nursing Home Replacement_ColoradoCityTX_20904" _
	and Subfolder.Path <> "N:\National\NAVFAC Newport P478 Gateway Inn And Suites_20852" _
	and Subfolder.Path <> "N:\National\Allen Oaks Nursing Home Oak Dale LA_21019" _
	and Subfolder.Path <> "N:\National\USPS Flagler Station Bldg Exp Miami FL_21020" _
	and Subfolder.Path <> "N:\National\Jack Links Jerky Mfg Fac Minong WI_21056" _
	and Subfolder.Path <> "N:\National\_National Small Jobs" _
	and Subfolder.Path <> "N:\National\Clancy Consolidated Warehouse Kent NY_21036" _
	and Subfolder.Path <> "N:\National\Amazon Fresh & Prime Now Denver_20962" _
	and Subfolder.Path <> "N:\National\USPS Mail Processing Annex Nashville TN_21030\Project_Documents\RFP-Solicitation\RFP-RFO_SFO\2017 Standard Design Criteria\D - Drawing Library\1 Prototype Drawings" _
	and Subfolder.Path <> "N:\National\USPS Mail Processing Annex Nashville TN_21030" _
	and Subfolder.Path <> "N:\National\COE Civil Eng Admin Ops Facility Beale CA_20836 69001" _
	and Subfolder.Path <> "N:\National\Parkview Hospital Majority Hospital Replacement Wheeler TX_20960" _
	and Subfolder.Path <> "N:\National\COE FY16 551st Squad Ops Cannon AFB NM_20963_70003" _
	and Subfolder.Path <> "N:\National\Southwest Care Center Santa Fe_NM_20990" _
	and Subfolder.Path <> "N:\National\Moore County Long Term Care Dumas TX_20861" _
	and Subfolder.Path <> "N:\National\Medical Arts Center (MAC) Shell & Parking Garage TheWoodlands_21003" _
	and Subfolder.Path <> "N:\National\Ecogy Solar Lincolnville ME_21050" _
	and Subfolder.Path <> "N:\National\_National TM Jobs" _
	and Subfolder.Path <> "N:\National\MWR Carlisle Barracks Golf Course Club House Carlisle PA_21040" _
	and Subfolder.Path <> "N:\National\MWR Flight Line Marine Mart Yuma AZ_21046" _
	and Subfolder.Path <> "N:\National\Air Products Winding Hall Exp Palmetto FL_21039" _
	and Subfolder.Path <> "N:\National\Coon Memorial Hosp Senior Living Exp_Dalhart_TX_20983" _
	and Subfolder.Path <> "N:\National\000 CGilliam" _
	then

'	and Subfolder.Path <> "N:\National\COE Army Reserve Center UniontownPA_20712 62001" 
'	and Subfolder.Path <> "N:\National\USPS P&DC Expansion Miami FL_20903" 
'	and Subfolder.Path <> "N:\National\VA Outpatient Clinic Redding CA_21025" 

'	and Subfolder.Path <> "N:\National\"
'	and Subfolder.Path <> "N:\National\"

		if Subfolder.name = ".AppleDouble" then
			wscript.echo "deleting: " & Subfolder.Path
			FSO.DeleteFolder Subfolder.Path, True		
		else
			FolderDepth = len(Subfolder.Path) - len(replace(Subfolder.Path,"\","")) - 1
			'wscript.echo Subfolder.Path
			'if FolderDepth = 3 then
			'	wscript.echo Subfolder.Path
			'end if
			ShowSubFolders Subfolder, FolderDepth -1 
		end if
        end if
        end if
        Next

    End if


End Sub


