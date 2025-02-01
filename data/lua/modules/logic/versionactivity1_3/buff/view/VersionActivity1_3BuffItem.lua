module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffItem", package.seeall)

slot0 = class("VersionActivity1_3BuffItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageBuffBG = gohelper.findChildImage(slot0.viewGO, "Root/#image_BuffBG")
	slot0._imageBuffBG1 = gohelper.findChildImage(slot0.viewGO, "Root/#image_BuffBG1")
	slot0._imageBuffIcon = gohelper.findChildImage(slot0.viewGO, "Root/#image_BuffIcon")
	slot0._simageBuffIcon1 = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_BuffIcon1")
	slot0._simageBuffIcon2 = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_BuffIcon2")
	slot0._goUnLocked = gohelper.findChild(slot0.viewGO, "Root/#go_UnLocked")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "Root/#go_Locked")
	slot0._simageBuffNumBg = gohelper.findChildSingleImage(slot0.viewGO, "Root/#go_Locked/#simage_BuffNumBg")
	slot0._txtBuffNum = gohelper.findChildText(slot0.viewGO, "Root/#go_Locked/#txt_BuffNum")
	slot0._gotaskLocked = gohelper.findChild(slot0.viewGO, "Root/#go_Locked/#go_taskLocked")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffTipView, {
		slot0._config,
		slot0._isLock,
		slot0._canGet,
		slot0
	})
end

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._pathGo = slot1[2]
	slot0._pathMat = slot0._pathGo:GetComponent(gohelper.Type_Image).material

	slot0:_changeSub(0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._simageBuffNumBg, false)

	slot0._matKey = UnityEngine.Shader.PropertyToID("_Sub")

	UISpriteSetMgr.instance:setV1a3BuffIconSprite(slot0._imageBuffIcon, slot0._config.icon, true)

	slot1 = string.format("singlebg/v1a3_buffview_singlebg/%s.png", slot0._config.icon)

	slot0._simageBuffIcon1:LoadImage(slot1, slot0._loadDone1, slot0)
	slot0._simageBuffIcon2:LoadImage(slot1, slot0._loadDone2, slot0)

	slot2 = gohelper.findChildImage(slot0.viewGO, "Root/#simage_BuffIcon1")
	slot3 = UnityEngine.GameObject.Instantiate(slot2.material)
	slot2.material = slot3
	slot4 = gohelper.findChild(slot0.viewGO, "Root")
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot4)
	slot0._animator = slot4:GetComponent(typeof(UnityEngine.Animator))
	slot0._animator.enabled = false
	slot4:GetComponent(typeof(ZProj.MaterialPropsCtrl)).mas[0] = slot3
	slot0._goVx1 = gohelper.findChild(slot0.viewGO, "Root/vx/1")
	slot0._goVx2 = gohelper.findChild(slot0.viewGO, "Root/vx/2")
	slot7 = slot0._config.dreamlandCard == 0

	gohelper.setActive(slot0._goVx1, slot7)
	gohelper.setActive(slot0._goVx2, not slot7)
	slot0:updateStatus()
end

function slot0._loadDone1(slot0)
	gohelper.findChildImage(slot0.viewGO, "Root/#simage_BuffIcon1"):SetNativeSize()
end

function slot0._loadDone2(slot0)
	gohelper.findChildImage(slot0.viewGO, "Root/#simage_BuffIcon2"):SetNativeSize()
end

function slot0.showLockToast(slot0)
	return slot0:_checkCanGet(true)
end

function slot0._checkCanGet(slot0, slot1)
	slot2 = true
	slot3 = true
	slot4 = true

	if not string.nilorempty(slot0._config.cost) then
		slot6 = string.splitToNumber(slot5, "#")

		if not (slot6[3] <= ItemModel.instance:getItemQuantity(slot6[1], slot6[2])) and slot1 then
			return formatLuaLang("versionactivity1_3_buff_tip1", slot7)
		end
	end

	if slot0._config.preBuffId > 0 and not Activity126Model.instance:hasBuff(slot0._config.preBuffId) and not false and slot1 then
		return luaLang("versionactivity1_3_buff_tip2")
	end

	if slot0._config.taskId > 0 and not TaskModel.instance:taskHasFinished(TaskEnum.TaskType.ActivityDungeon, slot0._config.taskId) then
		slot4 = false

		if slot1 then
			return
		end
	end

	return slot2 and slot3 and slot4
end

function slot0.updateStatus(slot0)
	UISpriteSetMgr.instance:setV1a3BuffIconSprite(slot0._imageBuffBG, not Activity126Model.instance:hasBuff(slot0._config.id) and "v1a3_buffview_bufficonbg_2" or "v1a3_buffview_bufficonbg_1")
	gohelper.setActive(slot0._goLocked, slot2)
	gohelper.setActive(slot0._goUnLocked, slot2 and slot0:_checkCanGet())

	if slot0._config.dreamlandCard == 0 then
		gohelper.setActive(slot0._pathGo, not slot2)
	end

	slot0._isLock = slot2
	slot0._canGet = slot3

	if not slot2 then
		slot0._animator.enabled = true

		slot0._animator:Play("idle", 0, 0)

		return
	end

	if slot2 then
		slot5 = string.splitToNumber(slot0._config.cost, "#")[3]

		gohelper.setActive(slot0._gotaskLocked, slot0._config.taskId > 0)

		slot0._txtBuffNum.text = slot5

		if slot5 and slot5 > 0 then
			gohelper.setActive(slot0._simageBuffNumBg, true)
		end
	else
		slot0._imageBuffIcon.color = Color.white

		ZProj.UGUIHelper.SetGrayscale(slot0._imageBuffIcon.gameObject, false)
		gohelper.setActive(slot0._simageBuffIcon1, true)
		gohelper.setActive(slot0._simageBuffIcon2, true)
	end
end

function slot0.onUnlockBuffReply(slot0)
	if slot0._isLock and Activity126Model.instance:hasBuff(slot0._config.id) then
		slot0._isLock = nil

		UIBlockMgr.instance:startBlock("1_3UnlockBuffReply")

		if slot0._config.dreamlandCard == 0 then
			slot0:_showUnlockAnim()
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_special)
			slot0:_onTweenFinish()
		end
	else
		slot0:updateStatus()
	end
end

function slot0._showUnlockAnim(slot0)
	slot0:_changeSub(1)
	gohelper.setActive(slot0._pathGo, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_general)

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0.5, 1, slot0._onTweenFrame, slot0._onTweenFinish, slot0, nil, EaseType.Linear)
end

function slot0._onTweenFrame(slot0, slot1)
	slot0:_changeSub(slot1)
end

function slot0._onTweenFinish(slot0)
	slot0:_changeSub(0)

	slot0._animator.enabled = true

	slot0._animator:Play("unlock", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(slot0._unlockDone, slot0)
	TaskDispatcher.runDelay(slot0._unlockDone, slot0, 2)
end

function slot0._unlockDone(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
	GameFacade.showToast(ToastEnum.Activity126_tip10, slot0._config.name)
end

function slot0._changeSub(slot0, slot1)
	slot0._pathMat:SetFloat(slot0._matKey, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simageBuffIcon1:UnLoadImage()
	slot0._simageBuffIcon2:UnLoadImage()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0._unlockDone, slot0)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
end

return slot0
