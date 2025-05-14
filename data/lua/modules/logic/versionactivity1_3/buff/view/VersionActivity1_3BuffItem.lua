module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffItem", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageBuffBG = gohelper.findChildImage(arg_1_0.viewGO, "Root/#image_BuffBG")
	arg_1_0._imageBuffBG1 = gohelper.findChildImage(arg_1_0.viewGO, "Root/#image_BuffBG1")
	arg_1_0._imageBuffIcon = gohelper.findChildImage(arg_1_0.viewGO, "Root/#image_BuffIcon")
	arg_1_0._simageBuffIcon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_BuffIcon1")
	arg_1_0._simageBuffIcon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_BuffIcon2")
	arg_1_0._goUnLocked = gohelper.findChild(arg_1_0.viewGO, "Root/#go_UnLocked")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Locked")
	arg_1_0._simageBuffNumBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#go_Locked/#simage_BuffNumBg")
	arg_1_0._txtBuffNum = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_Locked/#txt_BuffNum")
	arg_1_0._gotaskLocked = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Locked/#go_taskLocked")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3BuffTipView, {
		arg_4_0._config,
		arg_4_0._isLock,
		arg_4_0._canGet,
		arg_4_0
	})
end

function var_0_0.ctor(arg_5_0, arg_5_1)
	arg_5_0._config = arg_5_1[1]
	arg_5_0._pathGo = arg_5_1[2]
	arg_5_0._pathMat = arg_5_0._pathGo:GetComponent(gohelper.Type_Image).material

	arg_5_0:_changeSub(0)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._simageBuffNumBg, false)

	arg_6_0._matKey = UnityEngine.Shader.PropertyToID("_Sub")

	UISpriteSetMgr.instance:setV1a3BuffIconSprite(arg_6_0._imageBuffIcon, arg_6_0._config.icon, true)

	local var_6_0 = string.format("singlebg/v1a3_buffview_singlebg/%s.png", arg_6_0._config.icon)

	arg_6_0._simageBuffIcon1:LoadImage(var_6_0, arg_6_0._loadDone1, arg_6_0)
	arg_6_0._simageBuffIcon2:LoadImage(var_6_0, arg_6_0._loadDone2, arg_6_0)

	local var_6_1 = gohelper.findChildImage(arg_6_0.viewGO, "Root/#simage_BuffIcon1")
	local var_6_2 = UnityEngine.GameObject.Instantiate(var_6_1.material)

	var_6_1.material = var_6_2

	local var_6_3 = gohelper.findChild(arg_6_0.viewGO, "Root")

	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(var_6_3)
	arg_6_0._animator = var_6_3:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animator.enabled = false
	var_6_3:GetComponent(typeof(ZProj.MaterialPropsCtrl)).mas[0] = var_6_2
	arg_6_0._goVx1 = gohelper.findChild(arg_6_0.viewGO, "Root/vx/1")
	arg_6_0._goVx2 = gohelper.findChild(arg_6_0.viewGO, "Root/vx/2")

	local var_6_4 = arg_6_0._config.dreamlandCard == 0

	gohelper.setActive(arg_6_0._goVx1, var_6_4)
	gohelper.setActive(arg_6_0._goVx2, not var_6_4)
	arg_6_0:updateStatus()
end

function var_0_0._loadDone1(arg_7_0)
	gohelper.findChildImage(arg_7_0.viewGO, "Root/#simage_BuffIcon1"):SetNativeSize()
end

function var_0_0._loadDone2(arg_8_0)
	gohelper.findChildImage(arg_8_0.viewGO, "Root/#simage_BuffIcon2"):SetNativeSize()
end

function var_0_0.showLockToast(arg_9_0)
	return arg_9_0:_checkCanGet(true)
end

function var_0_0._checkCanGet(arg_10_0, arg_10_1)
	local var_10_0 = true
	local var_10_1 = true
	local var_10_2 = true
	local var_10_3 = arg_10_0._config.cost

	if not string.nilorempty(var_10_3) then
		local var_10_4 = string.splitToNumber(var_10_3, "#")
		local var_10_5 = var_10_4[3]

		var_10_0 = var_10_5 <= ItemModel.instance:getItemQuantity(var_10_4[1], var_10_4[2])

		if not var_10_0 and arg_10_1 then
			return formatLuaLang("versionactivity1_3_buff_tip1", var_10_5)
		end
	end

	if arg_10_0._config.preBuffId > 0 and not Activity126Model.instance:hasBuff(arg_10_0._config.preBuffId) then
		var_10_1 = false

		if not var_10_1 and arg_10_1 then
			return luaLang("versionactivity1_3_buff_tip2")
		end
	end

	if arg_10_0._config.taskId > 0 and not TaskModel.instance:taskHasFinished(TaskEnum.TaskType.ActivityDungeon, arg_10_0._config.taskId) then
		var_10_2 = false

		if arg_10_1 then
			return
		end
	end

	return var_10_0 and var_10_1 and var_10_2
end

function var_0_0.updateStatus(arg_11_0)
	local var_11_0 = arg_11_0._config.id
	local var_11_1 = not Activity126Model.instance:hasBuff(var_11_0)
	local var_11_2 = arg_11_0:_checkCanGet()

	UISpriteSetMgr.instance:setV1a3BuffIconSprite(arg_11_0._imageBuffBG, var_11_1 and "v1a3_buffview_bufficonbg_2" or "v1a3_buffview_bufficonbg_1")
	gohelper.setActive(arg_11_0._goLocked, var_11_1)
	gohelper.setActive(arg_11_0._goUnLocked, var_11_1 and var_11_2)

	if arg_11_0._config.dreamlandCard == 0 then
		gohelper.setActive(arg_11_0._pathGo, not var_11_1)
	end

	arg_11_0._isLock = var_11_1
	arg_11_0._canGet = var_11_2

	if not var_11_1 then
		arg_11_0._animator.enabled = true

		arg_11_0._animator:Play("idle", 0, 0)

		return
	end

	if var_11_1 then
		local var_11_3 = string.splitToNumber(arg_11_0._config.cost, "#")[3]

		gohelper.setActive(arg_11_0._gotaskLocked, arg_11_0._config.taskId > 0)

		arg_11_0._txtBuffNum.text = var_11_3

		if var_11_3 and var_11_3 > 0 then
			gohelper.setActive(arg_11_0._simageBuffNumBg, true)
		end
	else
		arg_11_0._imageBuffIcon.color = Color.white

		ZProj.UGUIHelper.SetGrayscale(arg_11_0._imageBuffIcon.gameObject, false)
		gohelper.setActive(arg_11_0._simageBuffIcon1, true)
		gohelper.setActive(arg_11_0._simageBuffIcon2, true)
	end
end

function var_0_0.onUnlockBuffReply(arg_12_0)
	if arg_12_0._isLock and Activity126Model.instance:hasBuff(arg_12_0._config.id) then
		arg_12_0._isLock = nil

		UIBlockMgr.instance:startBlock("1_3UnlockBuffReply")

		if arg_12_0._config.dreamlandCard == 0 then
			arg_12_0:_showUnlockAnim()
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_special)
			arg_12_0:_onTweenFinish()
		end
	else
		arg_12_0:updateStatus()
	end
end

function var_0_0._showUnlockAnim(arg_13_0)
	arg_13_0:_changeSub(1)
	gohelper.setActive(arg_13_0._pathGo, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_unlock_general)

	arg_13_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0.5, 1, arg_13_0._onTweenFrame, arg_13_0._onTweenFinish, arg_13_0, nil, EaseType.Linear)
end

function var_0_0._onTweenFrame(arg_14_0, arg_14_1)
	arg_14_0:_changeSub(arg_14_1)
end

function var_0_0._onTweenFinish(arg_15_0)
	arg_15_0:_changeSub(0)

	arg_15_0._animator.enabled = true

	arg_15_0._animator:Play("unlock", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(arg_15_0._unlockDone, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._unlockDone, arg_15_0, 2)
end

function var_0_0._unlockDone(arg_16_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
	GameFacade.showToast(ToastEnum.Activity126_tip10, arg_16_0._config.name)
end

function var_0_0._changeSub(arg_17_0, arg_17_1)
	arg_17_0._pathMat:SetFloat(arg_17_0._matKey, arg_17_1)
end

function var_0_0.onUpdateMO(arg_18_0, arg_18_1)
	return
end

function var_0_0.onSelect(arg_19_0, arg_19_1)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simageBuffIcon1:UnLoadImage()
	arg_20_0._simageBuffIcon2:UnLoadImage()

	if arg_20_0._tweenId then
		ZProj.TweenHelper.KillById(arg_20_0._tweenId)
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_20_0._unlockDone, arg_20_0)
	UIBlockMgr.instance:endBlock("1_3UnlockBuffReply")
end

return var_0_0
