module("modules.logic.rouge.view.RougeFavoriteCollectionView", package.seeall)

local var_0_0 = class("RougeFavoriteCollectionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottom")
	arg_1_0._btnlist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#btn_list")
	arg_1_0._golistselected = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#btn_list/#go_list_selected")
	arg_1_0._btnhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottom/#btn_handbook")
	arg_1_0._gohandbookselected = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#btn_handbook/#go_handbook_selected")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlist:AddClickListener(arg_2_0._btnlistOnClick, arg_2_0)
	arg_2_0._btnhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlist:RemoveClickListener()
	arg_3_0._btnhandbook:RemoveClickListener()
end

function var_0_0._btnlistOnClick(arg_4_0)
	if arg_4_0._listSelected then
		return
	end

	arg_4_0.viewContainer:selectTabView(1)
	arg_4_0:_setBtnListSelected(true)
end

function var_0_0._btnhandbookOnClick(arg_5_0)
	if arg_5_0._listSelected == false then
		return
	end

	arg_5_0.viewContainer:selectTabView(2)
	arg_5_0:_setBtnListSelected(false)
end

function var_0_0._setBtnListSelected(arg_6_0, arg_6_1)
	arg_6_0._listSelected = arg_6_1

	gohelper.setActive(arg_6_0._golistselected, arg_6_1)
	gohelper.setActive(arg_6_0._gohandbookselected, not arg_6_1)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:_setBtnListSelected(true)
	gohelper.setActive(arg_7_0._gobottom, RougeOutsideModel.instance:passedLayerId(RougeEnum.FirstLayerId))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio6)
end

function var_0_0.onClose(arg_10_0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0 then
		local var_10_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_10_0, RougeEnum.FavoriteType.Collection, 0)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
