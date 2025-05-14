module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipView", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._simageTipsBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_TipsBG")
	arg_1_0._simageBuffIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_BuffIcon")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Title")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Desc")
	arg_1_0._gounlockcardtip = gohelper.findChild(arg_1_0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/Effect/#go_unlockcardtip")
	arg_1_0._txtEffectDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_EffectDesc")
	arg_1_0._goLockTips = gohelper.findChild(arg_1_0.viewGO, "Root/Info/#go_LockTips")
	arg_1_0._txtLockTips = gohelper.findChildText(arg_1_0.viewGO, "Root/Info/#go_LockTips/#txt_LockTips")
	arg_1_0._btnUnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Info/#btn_UnLock")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Info/#btn_lock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnUnLock:AddClickListener(arg_2_0._btnUnLockOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnUnLock:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
end

function var_0_0._btnlockOnClick(arg_4_0)
	return
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnUnLockOnClick(arg_6_0)
	Activity126Rpc.instance:sendUnlockBuffRequest(VersionActivity1_3Enum.ActivityId.Act310, arg_6_0._config.id)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simageclosebtn = gohelper.findChildSingleImage(arg_7_0.viewGO, "#btn_Close")

	arg_7_0._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	arg_7_0._simageTipsBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_tipsbg"))
	gohelper.setActive(arg_7_0._gounlockcardtip, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._config = arg_9_0.viewParam[1]
	arg_9_0._isLock = arg_9_0.viewParam[2]
	arg_9_0._canGet = arg_9_0.viewParam[3]
	arg_9_0._buffItem = arg_9_0.viewParam[4]
	arg_9_0._txtTitle.text = arg_9_0._config.name
	arg_9_0._txtDesc.text = arg_9_0._config.desc

	local var_9_0 = string.format("singlebg/v1a3_bigbufficon_singlebg/%s.png", arg_9_0._config.bigIcon)

	arg_9_0._simageBuffIcon:LoadImage(var_9_0)

	arg_9_0._txtEffectDesc.text = ""

	local var_9_1 = arg_9_0._config.skillId

	if arg_9_0._config.dreamlandCard > 0 then
		var_9_1 = lua_activity126_dreamland_card.configDict[arg_9_0._config.dreamlandCard].skillId

		gohelper.setActive(arg_9_0._gounlockcardtip, true)
	end

	if var_9_1 > 0 then
		local var_9_2 = lua_skill_effect.configDict[var_9_1]

		arg_9_0._txtEffectDesc.text = FightConfig.instance:getSkillEffectDesc("", var_9_2)
	end

	gohelper.setActive(arg_9_0._btnlock, false)
	gohelper.setActive(arg_9_0._btnUnLock, arg_9_0._isLock and arg_9_0._canGet)

	if not arg_9_0._canGet then
		if arg_9_0._config.taskId > 0 then
			gohelper.setActive(arg_9_0._btnUnLock, false)

			local var_9_3 = lua_activity113_task.configDict[arg_9_0._config.taskId]

			arg_9_0._txtLockTips.text = formatLuaLang("versionactivity1_3bufftipview_locktips", var_9_3.desc)
		else
			arg_9_0._txtLockTips.text = arg_9_0._buffItem:showLockToast()
		end
	end

	gohelper.setActive(arg_9_0._txtLockTips, arg_9_0._isLock and not arg_9_0._canGet)
	arg_9_0:addEventCb(Activity126Controller.instance, Activity126Event.onUnlockBuffReply, arg_9_0._onUnlockBuffReply, arg_9_0)
end

function var_0_0._onUnlockBuffReply(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageclosebtn:UnLoadImage()
	arg_12_0._simageTipsBG:UnLoadImage()
end

return var_0_0
