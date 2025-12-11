module("modules.logic.activity.view.V3a3_DoubleDanActivity_FullView", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivity_FullView", V3a3_DoubleDanActivityViewImpl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_Role")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#simage_l2d")
	arg_1_0._gospinecontainer = gohelper.findChild(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_characterName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_characterName/#txt_skinNameEn")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_skinName")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_switch")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "Left/#btn_switch/#txt_switch")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Go")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_Claim")
	arg_1_0._btnClaimed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_Claimed")
	arg_1_0._btnUnopen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_Unopen")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/Tab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/Tab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/Tab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	arg_1_0._goClaim = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#go_Claim")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnClaimed:AddClickListener(arg_2_0._btnClaimedOnClick, arg_2_0)
	arg_2_0._btnUnopen:AddClickListener(arg_2_0._btnUnopenOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClaimed:RemoveClickListener()
	arg_3_0._btnUnopen:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	var_0_0.super.onDestroyView(arg_6_0)
end

return var_0_0
