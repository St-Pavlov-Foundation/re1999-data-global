module("modules.logic.activity.view.V3a3_DoubleDanActivity_PanelView", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivity_PanelView", V3a3_DoubleDanActivityViewImpl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
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
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")
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
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnClaimed:RemoveClickListener()
	arg_3_0._btnUnopen:RemoveClickListener()
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.ctor(arg_9_0, ...)
	var_0_0.super.ctor(arg_9_0, ...)
end

function var_0_0._editableInitView(arg_10_0)
	var_0_0.super._editableInitView(arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	var_0_0.super.onDestroyView(arg_11_0)
end

return var_0_0
