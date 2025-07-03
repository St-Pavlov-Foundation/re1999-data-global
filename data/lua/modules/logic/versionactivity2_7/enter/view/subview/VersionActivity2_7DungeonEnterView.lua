module("modules.logic.versionactivity2_7.enter.view.subview.VersionActivity2_7DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_7DungeonEnterView", VersionActivityFixedDungeonEnterView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/image_TimeBG/#txt_time")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._gohardModeUnLock = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_hardModeUnLock")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

return var_0_0
