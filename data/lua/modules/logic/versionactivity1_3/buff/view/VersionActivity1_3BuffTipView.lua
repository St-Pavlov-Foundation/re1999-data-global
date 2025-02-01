module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipView", package.seeall)

slot0 = class("VersionActivity1_3BuffTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._simageTipsBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_TipsBG")
	slot0._simageBuffIcon = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_BuffIcon")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Title")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_Desc")
	slot0._gounlockcardtip = gohelper.findChild(slot0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/Effect/#go_unlockcardtip")
	slot0._txtEffectDesc = gohelper.findChildText(slot0.viewGO, "Root/Info/Scroll View/Viewport/LayoutGroup/#txt_EffectDesc")
	slot0._goLockTips = gohelper.findChild(slot0.viewGO, "Root/Info/#go_LockTips")
	slot0._txtLockTips = gohelper.findChildText(slot0.viewGO, "Root/Info/#go_LockTips/#txt_LockTips")
	slot0._btnUnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Info/#btn_UnLock")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Info/#btn_lock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnUnLock:AddClickListener(slot0._btnUnLockOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnlockOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnUnLock:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
end

function slot0._btnlockOnClick(slot0)
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnUnLockOnClick(slot0)
	Activity126Rpc.instance:sendUnlockBuffRequest(VersionActivity1_3Enum.ActivityId.Act310, slot0._config.id)
end

function slot0._editableInitView(slot0)
	slot0._simageclosebtn = gohelper.findChildSingleImage(slot0.viewGO, "#btn_Close")

	slot0._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	slot0._simageTipsBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_tipsbg"))
	gohelper.setActive(slot0._gounlockcardtip, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._config = slot0.viewParam[1]
	slot0._isLock = slot0.viewParam[2]
	slot0._canGet = slot0.viewParam[3]
	slot0._buffItem = slot0.viewParam[4]
	slot0._txtTitle.text = slot0._config.name
	slot0._txtDesc.text = slot0._config.desc

	slot0._simageBuffIcon:LoadImage(string.format("singlebg/v1a3_bigbufficon_singlebg/%s.png", slot0._config.bigIcon))

	slot0._txtEffectDesc.text = ""
	slot2 = slot0._config.skillId

	if slot0._config.dreamlandCard > 0 then
		slot2 = lua_activity126_dreamland_card.configDict[slot0._config.dreamlandCard].skillId

		gohelper.setActive(slot0._gounlockcardtip, true)
	end

	if slot2 > 0 then
		slot0._txtEffectDesc.text = FightConfig.instance:getSkillEffectDesc("", lua_skill_effect.configDict[slot2])
	end

	gohelper.setActive(slot0._btnlock, false)
	gohelper.setActive(slot0._btnUnLock, slot0._isLock and slot0._canGet)

	if not slot0._canGet then
		if slot0._config.taskId > 0 then
			gohelper.setActive(slot0._btnUnLock, false)

			slot0._txtLockTips.text = formatLuaLang("versionactivity1_3bufftipview_locktips", lua_activity113_task.configDict[slot0._config.taskId].desc)
		else
			slot0._txtLockTips.text = slot0._buffItem:showLockToast()
		end
	end

	gohelper.setActive(slot0._txtLockTips, slot0._isLock and not slot0._canGet)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onUnlockBuffReply, slot0._onUnlockBuffReply, slot0)
end

function slot0._onUnlockBuffReply(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageclosebtn:UnLoadImage()
	slot0._simageTipsBG:UnLoadImage()
end

return slot0
