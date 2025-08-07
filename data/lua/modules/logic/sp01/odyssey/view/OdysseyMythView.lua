module("modules.logic.sp01.odyssey.view.OdysseyMythView", package.seeall)

local var_0_0 = class("OdysseyMythView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBossContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_BossContent")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_BossContent/#go_bossItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnMythItemOnClick(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.config.elementId

	if not OdysseyDungeonModel.instance:getElementMo(var_4_0) then
		GameFacade.showToast(ToastEnum.OdysseyMythLock)

		return
	end

	OdysseyDungeonController.instance:jumpToMapElement(var_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.mythItemMap = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._gobossItem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshUI()
	arg_7_0:playUnlockEffect()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.mythConfigList = OdysseyConfig.instance:getMythConfigList()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.mythConfigList) do
		local var_8_0 = arg_8_0.mythItemMap[iter_8_1.id]

		if not var_8_0 then
			var_8_0 = {
				config = iter_8_1,
				go = gohelper.clone(arg_8_0._gobossItem, arg_8_0._goBossContent)
			}
			var_8_0.lock = gohelper.findChild(var_8_0.go, "lock")
			var_8_0.unlock = gohelper.findChild(var_8_0.go, "unlock")
			var_8_0.simageBoss = gohelper.findChildSingleImage(var_8_0.go, "unlock/simage_boss")
			var_8_0.imageBoss = gohelper.findChildImage(var_8_0.go, "unlock/simage_boss")
			var_8_0.txtName = gohelper.findChildText(var_8_0.go, "unlock/txt_bossName")
			var_8_0.golevel = gohelper.findChild(var_8_0.go, "unlock/go_level")
			var_8_0.simageLevel = gohelper.findChildSingleImage(var_8_0.go, "unlock/go_level/simage_level")
			var_8_0.imageRecord = gohelper.findChildImage(var_8_0.go, "unlock/go_level/image_record")
			var_8_0.imageRecordGlow = gohelper.findChildImage(var_8_0.go, "unlock/go_level/image_record_glow")
			var_8_0.btnClick = gohelper.findChildButtonWithAudio(var_8_0.go, "btn_click")

			var_8_0.btnClick:AddClickListener(arg_8_0._btnMythItemOnClick, arg_8_0, var_8_0)

			var_8_0.frameEffectGOMap = {}

			for iter_8_2 = 1, 3 do
				var_8_0.frameEffectGOMap[iter_8_2] = gohelper.findChild(var_8_0.go, "unlock/go_level/vx_glow/" .. iter_8_2)
			end

			var_8_0.material = var_8_0.imageBoss.material
			var_8_0.imageBoss.material = UnityEngine.Object.Instantiate(var_8_0.material)
			var_8_0.materialPropsCtrl = var_8_0.go:GetComponent(typeof(ZProj.MaterialPropsCtrl))

			var_8_0.materialPropsCtrl.mas:Clear()
			var_8_0.materialPropsCtrl.mas:Add(var_8_0.imageBoss.material)

			var_8_0.anim = var_8_0.go:GetComponent(gohelper.Type_Animator)
			arg_8_0.mythItemMap[iter_8_1.id] = var_8_0
		end

		gohelper.setActive(var_8_0.go, true)

		local var_8_1 = OdysseyDungeonModel.instance:getElementMo(iter_8_1.elementId)

		gohelper.setActive(var_8_0.lock, not var_8_1)
		gohelper.setActive(var_8_0.unlock, var_8_1)

		if var_8_1 then
			var_8_0.simageBoss:LoadImage(ResUrl.getSp01OdysseySingleBg(iter_8_1.res))

			var_8_0.txtName.text = iter_8_1.name

			local var_8_2 = var_8_1:getMythicEleData()

			gohelper.setActive(var_8_0.golevel, var_8_2 and var_8_2.evaluation > 0)

			if var_8_2 and var_8_2.evaluation > 0 then
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_8_0.imageRecord, "pingji_d_" .. var_8_2.evaluation)
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_8_0.imageRecordGlow, "pingji_d_" .. var_8_2.evaluation)
				var_8_0.simageLevel:LoadImage(ResUrl.getSp01OdysseySingleBg("mythcreatures/odyssey_mythcreatures_level_" .. var_8_2.evaluation))

				for iter_8_3, iter_8_4 in pairs(var_8_0.frameEffectGOMap) do
					gohelper.setActive(iter_8_4, iter_8_3 == var_8_2.evaluation)
				end
			end
		end
	end
end

function var_0_0.playUnlockEffect(arg_9_0)
	local var_9_0 = OdysseyDungeonModel.instance:getCurUnlockMythIdList()
	local var_9_1, var_9_2 = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MythNew, var_9_0)

	if var_9_1 then
		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			local var_9_3 = arg_9_0.mythItemMap[iter_9_1]

			if var_9_3 then
				gohelper.setActive(var_9_3.lock, true)
				var_9_3.anim:Play("unlock", 0, 0)
				var_9_3.anim:Update(0)
			end
		end
	end
end

function var_0_0.onClose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.mythItemMap) do
		iter_10_1.btnClick:RemoveClickListener()
		iter_10_1.simageBoss:UnLoadImage()
		iter_10_1.simageLevel:UnLoadImage()
	end

	OdysseyDungeonModel.instance:saveLocalCurNewLock(OdysseyEnum.LocalSaveKey.MythNew, OdysseyDungeonModel.instance:getCurUnlockMythIdList())
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
