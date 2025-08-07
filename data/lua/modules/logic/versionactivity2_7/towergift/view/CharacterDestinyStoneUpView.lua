module("modules.logic.versionactivity2_7.towergift.view.CharacterDestinyStoneUpView", package.seeall)

local var_0_0 = class("CharacterDestinyStoneUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_icon")
	arg_1_0._txtstonename = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_stonename")
	arg_1_0._gostone = gohelper.findChild(arg_1_0.viewGO, "root/#go_stone")
	arg_1_0._gooncefull = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_oncefull")
	arg_1_0._btnoncefull = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_oncefull/#btn_oncefull")
	arg_1_0._gohasoncefull = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_hasoncefull")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "root/point/#go_point")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoncefull:AddClickListener(arg_2_0._btnoncefullOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, arg_2_0._onUnlockStoneReply, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoncefull:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, arg_3_0._onUnlockStoneReply, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
end

function var_0_0._btnoncefullOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.CharacterDestinyStoneUpView, MsgBoxEnum.BoxType.Yes_No, arg_4_0._useStoneUpTicket, nil, nil, arg_4_0, nil, nil)
end

function var_0_0._useCallback(arg_5_0)
	return
end

function var_0_0._useStoneUpTicket(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {
		materialId = arg_6_0._materialId
	}

	var_6_1.quantity = 1

	table.insert(var_6_0, var_6_1)
	ItemRpc.instance:sendUseItemRequest(var_6_0, arg_6_0._curStoneMo.stoneId)
end

function var_0_0._onItemChanged(arg_7_0)
	gohelper.setActive(arg_7_0._gooncefull, false)
	gohelper.setActive(arg_7_0._gohasoncefull, true)
	arg_7_0:_playAnim()
	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.hadStoneUp)
end

function var_0_0._playAnim(arg_8_0)
	if arg_8_0._isSlotMaxLevel then
		arg_8_0._animator:Play("allup", 0, 0)
		arg_8_0:_refreshStoneItem()
	elseif not arg_8_0._curStoneMo.isUnlock then
		arg_8_0._animator:Play("allup", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)

		function arg_8_0._cb()
			TaskDispatcher.cancelTask(arg_8_0._cb, arg_8_0)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
		end

		TaskDispatcher.runDelay(arg_8_0._cb, arg_8_0, 2.6)
		arg_8_0:_refreshStoneItem()
	else
		arg_8_0._animator:Play("allup", 0, 0)
		TaskDispatcher.runDelay(arg_8_0._onPlayAnimBack, arg_8_0, 2.6)
	end
end

function var_0_0._onPlayAnimBack(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onPlayAnimBack, arg_10_0)

	if arg_10_0._effectItems then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._effectItems) do
			local var_10_0 = arg_10_0._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(arg_10_0._curStoneMo.stoneId, iter_10_0)

			gohelper.setActive(iter_10_1.gounlock, var_10_0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_checkpoint_doom_disappear)
	arg_10_0:_refreshStoneItem()
end

function var_0_0._onUnlockStoneReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._curStoneMo then
		arg_11_0._curStoneMo:refresUnlock(true)
	end

	arg_11_0:_refreshStoneItem()
	gohelper.setActive(arg_11_0._root, true)
	gohelper.setActive(arg_11_0._gounlockstone, false)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._simagestone = gohelper.findChildSingleImage(arg_12_0.viewGO, "root/#go_stone/#simage_stone")
	arg_12_0._simagepre = gohelper.findChildSingleImage(arg_12_0.viewGO, "root/#go_prestone/#btn_prestone")
	arg_12_0._simagenext = gohelper.findChildSingleImage(arg_12_0.viewGO, "root/#go_nextstone/#btn_nextstone")
	arg_12_0._gounlockstone = gohelper.findChild(arg_12_0.viewGO, "unlockstone")
	arg_12_0._root = gohelper.findChild(arg_12_0.viewGO, "root")
	arg_12_0._goeffect = gohelper.findChild(arg_12_0.viewGO, "root/effectItem")
	arg_12_0._imgstone = gohelper.findChildImage(arg_12_0.viewGO, "root/#go_stone/#simage_stone")
	arg_12_0._goEquip = gohelper.findChild(arg_12_0.viewGO, "root/#go_stone/#equip")
	arg_12_0._animRoot = arg_12_0._root:GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(arg_12_0._root)
	arg_12_0._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(arg_12_0._gounlockstone)
	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_0._godrag.gameObject)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0._addEvents(arg_14_0)
	return
end

function var_0_0._removeEvents(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_addEvents()

	arg_16_0._effectItems = arg_16_0:getUserDataTb_()

	for iter_16_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_16_0 = gohelper.findChild(arg_16_0._goeffect, iter_16_0)
		local var_16_1 = arg_16_0:getUserDataTb_()

		var_16_1.go = var_16_0
		var_16_1.lockicon = gohelper.findChildImage(var_16_0, "#txt_dec/#go_lockicon")
		var_16_1.unlockicon = gohelper.findChildImage(var_16_0, "#txt_dec/#go_unlockicon")
		var_16_1.txt = gohelper.findChildText(var_16_0, "#txt_dec")
		var_16_1.gounlock = gohelper.findChild(var_16_0, "#unlock")
		var_16_1.canvasgroup = var_16_0:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_16_0._effectItems[iter_16_0] = var_16_1
	end

	arg_16_0._materialId = arg_16_0.viewParam.materialId
	arg_16_0._heroMO = arg_16_0.viewParam.heroMo
	arg_16_0._curStoneMo = arg_16_0.viewParam.stoneMo
	arg_16_0._destinyStoneMo = arg_16_0._heroMO.destinyStoneMo
	arg_16_0._isSlotMaxLevel = arg_16_0._destinyStoneMo:isSlotMaxLevel()

	if arg_16_0._curStoneMo then
		if not arg_16_0._unlockStoneView then
			arg_16_0._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_0._gounlockstone, CharacterDestinyUnlockStoneComp)

			arg_16_0._unlockStoneView:setStoneView(arg_16_0)
		end

		arg_16_0._unlockStoneView:onUpdateMo(arg_16_0._heroMO.heroId, arg_16_0._curStoneMo.stoneId)
		arg_16_0:_refreshStoneItem()
	end

	gohelper.setActive(arg_16_0._root, true)
end

function var_0_0._refreshStoneItem(arg_17_0)
	if arg_17_0._curStoneMo then
		arg_17_0._levelCos = arg_17_0._curStoneMo:getFacetCo()

		local var_17_0 = arg_17_0._curStoneMo.conusmeCo

		if arg_17_0._levelCos then
			for iter_17_0, iter_17_1 in ipairs(arg_17_0._effectItems) do
				local var_17_1 = arg_17_0._levelCos[iter_17_0]

				iter_17_1.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(iter_17_1.txt.gameObject, SkillDescComp)

				iter_17_1.skillDesc:updateInfo(iter_17_1.txt, var_17_1.desc, arg_17_0._heroMO.heroId)
				iter_17_1.skillDesc:setTipParam(0, Vector2(300, 100))

				local var_17_2 = arg_17_0._curStoneMo.isUnlock and iter_17_0 <= arg_17_0._heroMO.destinyStoneMo.rank
				local var_17_3 = iter_17_1.txt.color

				var_17_3.a = var_17_2 and 1 or 0.43
				iter_17_1.txt.color = var_17_3

				if var_17_2 then
					local var_17_4 = iter_17_1.unlockicon.color

					var_17_4.a = var_17_2 and 1 or 0.43
					iter_17_1.unlockicon.color = var_17_4
				else
					local var_17_5 = iter_17_1.lockicon.color

					var_17_5.a = var_17_2 and 1 or 0.43
					iter_17_1.lockicon.color = var_17_5
				end

				gohelper.setActive(iter_17_1.lockicon.gameObject, not var_17_2)
				gohelper.setActive(iter_17_1.unlockicon.gameObject, var_17_2)
			end
		end

		gohelper.setActive(arg_17_0._goEquip, arg_17_0._curStoneMo.isUse)

		if var_17_0 then
			local var_17_6, var_17_7 = arg_17_0._curStoneMo:getNameAndIcon()

			arg_17_0._txtstonename.text = var_17_6

			arg_17_0._simagestone:LoadImage(var_17_7)

			local var_17_8 = CharacterDestinyEnum.SlotTend[var_17_0.tend]
			local var_17_9 = var_17_8.TitleIconName

			UISpriteSetMgr.instance:setUiCharacterSprite(arg_17_0._imageicon, var_17_9)

			arg_17_0._txtstonename.color = GameUtil.parseColor(var_17_8.TitleColor)
		end

		local var_17_10 = arg_17_0._curStoneMo.isUnlock and Color.white or Color(0.5, 0.5, 0.5, 1)

		arg_17_0._imgstone.color = var_17_10
	end

	if not arg_17_0._pointItems then
		arg_17_0._pointItems = arg_17_0:getUserDataTb_()
	end
end

function var_0_0._getPointItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._pointItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_1 = gohelper.cloneInPlace(arg_18_0._gopoint, arg_18_1)

		var_18_0.go = var_18_1
		var_18_0.normal = gohelper.findChild(var_18_1, "normal")
		var_18_0.select = gohelper.findChild(var_18_1, "select")
		arg_18_0._pointItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._cb, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onPlayAnimBack, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:_removeEvents()
	arg_20_0._simagestone:UnLoadImage()
end

return var_0_0
