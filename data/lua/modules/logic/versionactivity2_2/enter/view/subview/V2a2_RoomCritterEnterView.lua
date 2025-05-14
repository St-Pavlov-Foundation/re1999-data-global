module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_RoomCritterEnterView", package.seeall)

local var_0_0 = class("V2a2_RoomCritterEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_start")
	arg_1_0._imagereddot = gohelper.findChildImage(arg_1_0.viewGO, "#btn_start/#image_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtdesc = gohelper.findChildText(arg_5_0.viewGO, "Right/txt_dec")
	arg_5_0.actId = VersionActivity2_2Enum.ActivityId.RoomCritter
	arg_5_0.actCo = ActivityConfig.instance:getActivityCo(arg_5_0.actId)

	if arg_5_0.actCo and arg_5_0._txtdesc then
		arg_5_0._txtdesc.text = arg_5_0.actCo.actDesc
	end
end

return var_0_0
