module("modules.logic.fight.view.FightSeasonSubHeroItem", package.seeall)

local var_0_0 = class("FightSeasonSubHeroItem", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._headIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Head")
	arg_1_0._hpSlider = gohelper.findChildImage(arg_1_0.viewGO, "infoPart/HP/#image_HPFG")
	arg_1_0._pointRoot = gohelper.findChild(arg_1_0.viewGO, "infoPart/Point")
	arg_1_0._pointItem = gohelper.findChild(arg_1_0.viewGO, "infoPart/Point/pointItem")
	arg_1_0._btn = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn")
	arg_1_0._aniPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._ani = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animator))
	arg_1_0._fillImage = gohelper.findChildImage(arg_1_0.viewGO, "#image_ItemBGFilled")

	local var_1_0 = UnityEngine.Object.Instantiate(arg_1_0._fillImage.material)

	arg_1_0._fillImage.material = var_1_0
	arg_1_0._fillMat = var_1_0
	arg_1_0._hpRoot = gohelper.findChild(arg_1_0.viewGO, "infoPart")
	arg_1_0._effectHeal = gohelper.findChild(arg_1_0.viewGO, "infoPart/eff_heal")
	arg_1_0._infoPart = gohelper.findChild(arg_1_0.viewGO, "infoPart")
	arg_1_0._point2Root = gohelper.findChild(arg_1_0.viewGO, "infoPart/Point2")
	arg_1_0._point2Item = gohelper.findChild(arg_1_0.viewGO, "infoPart/Point2/pointItem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0._btn, arg_2_0._onBtnClick)
	arg_2_0:com_registFightEvent(FightEvent.OnExPointChange, arg_2_0._onExPointChange)
	arg_2_0:com_registFightEvent(FightEvent.UpdateExPoint, arg_2_0._onUpdateExPoint)
	arg_2_0:com_registFightEvent(FightEvent.ReplaceEntityMO, arg_2_0._onReplaceEntityMO)
	arg_2_0:com_registFightEvent(FightEvent.BeforeChangeSubHero, arg_2_0._onBeforeChangeSubHero)
	arg_2_0:com_registFightEvent(FightEvent.ChangeSubEntityHp, arg_2_0._onChangeSubEntityHp)
	arg_2_0:com_registFightEvent(FightEvent.EntitySync, arg_2_0._onEntitySync)
	arg_2_0:com_registFightEvent(FightEvent.ChangeEntitySubCd, arg_2_0._onChangeEntitySubCd)
	arg_2_0:com_registFightEvent(FightEvent.StageChanged, arg_2_0._onStageChanged)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onExPointChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == arg_4_0._entityId then
		arg_4_0:com_registSingleTimer(arg_4_0._delayHideInfo, 0.6)
		arg_4_0:_refreshExpoint(true, arg_4_2, arg_4_3)

		if arg_4_0:_canUse() then
			arg_4_0:playAni("max_in", true)
			AudioMgr.instance:trigger(410000105)
		else
			arg_4_0:refreshAni()
		end

		if arg_4_3 == 5 then
			FightController.instance:dispatchEvent(FightEvent.GuideSubEntityExpoint5)
		end
	end
end

function var_0_0._delayHideInfo(arg_5_0)
	local var_5_0 = arg_5_0:_canUse()

	gohelper.setActive(arg_5_0._effectHeal, false)
end

function var_0_0._onUpdateExPoint(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:_onExPointChange(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0._onReplaceEntityMO(arg_7_0, arg_7_1)
	if arg_7_1.id == arg_7_0._entityId then
		arg_7_0:refreshData(arg_7_0._entityId)
	end
end

function var_0_0._onBeforeChangeSubHero(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == arg_8_0._entityId then
		local var_8_0 = FightDataHelper.entityMgr:getById(arg_8_1)

		if var_8_0 and var_8_0:isStatusDead() then
			arg_8_0.PARENT_VIEW:onOpen()

			return
		end

		arg_8_0:refreshData(arg_8_1)
	end
end

function var_0_0._onChangeSubEntityHp(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == arg_9_0._entityId then
		arg_9_0:_refreshHp(true)

		if arg_9_2 > 0 then
			arg_9_0:com_registSingleTimer(arg_9_0._delayHideInfo, 0.6)
			gohelper.setActive(arg_9_0._effectHeal, true)
		end
	end
end

function var_0_0.onOpen(arg_10_0)
	gohelper.setActive(arg_10_0._effectHeal, false)
end

function var_0_0._canUse(arg_11_0)
	local var_11_0 = FightDataHelper.entityMgr:getById(arg_11_0._entityId)

	if var_11_0:getExPoint() >= var_11_0:getUniqueSkillPoint() then
		return true
	end
end

function var_0_0._onBtnClick(arg_12_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if not arg_12_0:_canUse() then
		return
	end

	if FightDataHelper.entityMgr:getById(arg_12_0._entityId).subCd ~= 0 then
		GameFacade.showToast(ToastEnum.CanNotUseSeasonChangeHeroCd)

		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.SeasonChangeHero then
			if arg_12_0.PARENT_VIEW:selecting(arg_12_0) then
				return
			end

			arg_12_0:selectItem()
		end

		return
	end

	arg_12_0.PARENT_VIEW:_enterOperate()
	arg_12_0:selectItem()
end

function var_0_0.selectItem(arg_13_0)
	AudioMgr.instance:trigger(410000106)
	arg_13_0.PARENT_VIEW:selectItem(arg_13_0)
end

function var_0_0._onChangeEntitySubCd(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0._entityId then
		arg_14_0:refreshAni()
	end
end

function var_0_0._onEntitySync(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0._entityId and FightDataHelper.entityMgr:getById(arg_15_0._entityId).subCd ~= 0 then
		arg_15_0:playAni("cd_in", true)
	end
end

function var_0_0._onStageChanged(arg_16_0, arg_16_1)
	arg_16_0:refreshAni()
end

function var_0_0.refreshAni(arg_17_0)
	if not arg_17_0.viewGO.activeInHierarchy then
		return
	end

	if FightDataHelper.entityMgr:getById(arg_17_0._entityId).subCd ~= 0 then
		arg_17_0:playAni("cd_idle", nil, true)
	elseif arg_17_0:_canUse() then
		arg_17_0:playAni("max_idle", nil, true)
	else
		arg_17_0:playAni("normal_idle", nil, true)
	end
end

function var_0_0.playAni(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_0.viewGO.activeInHierarchy then
		return
	end

	if arg_18_1 == "select_in" then
		arg_18_0._aniPlayer:Play(arg_18_1, nil, nil)
	elseif arg_18_2 then
		arg_18_0._aniPlayer:Play(arg_18_1, arg_18_0.refreshAni, arg_18_0)
	elseif arg_18_3 then
		arg_18_0._ani.enabled = true

		arg_18_0._ani:Play(arg_18_1)
	else
		arg_18_0._aniPlayer:Play(arg_18_1, nil, nil)
	end
end

function var_0_0.refreshData(arg_19_0, arg_19_1)
	arg_19_0._entityId = arg_19_1

	local var_19_0 = FightDataHelper.entityMgr:getById(arg_19_0._entityId)
	local var_19_1 = SkinConfig.instance:getSkinCo(var_19_0.skin)

	arg_19_0._headIcon:LoadImage(ResUrl.roomHeadIcon(var_19_1.headIcon))
	arg_19_0:_refreshExpoint()
	arg_19_0:_refreshHp()
	arg_19_0:refreshAni()

	local var_19_2 = arg_19_0:_canUse()
end

function var_0_0._buildDataListByNum(arg_20_0, arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 1, arg_20_1 do
		table.insert(var_20_0, iter_20_0)
	end

	return var_20_0
end

function var_0_0._refreshExpoint(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = FightDataHelper.entityMgr:getById(arg_21_0._entityId)

	arg_21_0._expointObj = {}
	arg_21_0._expointMax = var_21_0:getMaxExPoint()
	arg_21_0._curExpoint = var_21_0:getExPoint()

	gohelper.setActive(arg_21_0._point2Root, false)

	if arg_21_0._expointMax <= 6 then
		gohelper.CreateObjList(arg_21_0, arg_21_0._onPointItemShow, arg_21_0:_buildDataListByNum(math.min(arg_21_0._expointMax, 6)), arg_21_0._pointRoot, arg_21_0._pointItem)
	elseif arg_21_0._expointMax <= 12 then
		gohelper.setActive(arg_21_0._point2Root, true)
		gohelper.CreateObjList(arg_21_0, arg_21_0._onPointItemShow, arg_21_0:_buildDataListByNum(6), arg_21_0._pointRoot, arg_21_0._pointItem)
		gohelper.CreateObjList(arg_21_0, arg_21_0._onPoint2ItemShow, arg_21_0:_buildDataListByNum(arg_21_0._expointMax - 6), arg_21_0._point2Root, arg_21_0._point2Item)
	else
		gohelper.CreateObjList(arg_21_0, arg_21_0._onPointItemShow, arg_21_0:_buildDataListByNum(arg_21_0._expointMax), arg_21_0._pointRoot, arg_21_0._pointItem)
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._expointObj) do
		gohelper.setActive(iter_21_1.light, iter_21_0 <= arg_21_0._curExpoint)
	end

	local var_21_1 = var_21_0:getUniqueSkillPoint()

	if arg_21_1 and arg_21_2 and arg_21_3 then
		arg_21_0:_releaseTween()

		arg_21_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_21_2 / var_21_1, arg_21_3 / var_21_1, 0.3 / FightModel.instance:getUISpeed(), arg_21_0._expointTweenCallback, nil, arg_21_0)

		if arg_21_2 < arg_21_3 then
			for iter_21_2 = arg_21_2 + 1, arg_21_3 do
				if arg_21_0._expointObj[iter_21_2] and arg_21_0.viewGO.activeInHierarchy then
					arg_21_0._expointObj[iter_21_2].ani:Play("in", nil, nil)
				end
			end
		end
	else
		arg_21_0._fillMat:SetFloat("_LerpOffset", arg_21_0._curExpoint / var_21_1)
	end
end

function var_0_0._expointTweenCallback(arg_22_0, arg_22_1)
	arg_22_0._fillMat:SetFloat("_LerpOffset", arg_22_1)
end

function var_0_0._releaseTween(arg_23_0)
	if arg_23_0._tweenId then
		ZProj.TweenHelper.KillById(arg_23_0._tweenId)

		arg_23_0._tweenId = nil
	end
end

function var_0_0._onPointItemShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if not arg_24_0._expointObj[arg_24_3] then
		arg_24_0._expointObj[arg_24_3] = arg_24_0:newUserDataTable()
		arg_24_0._expointObj[arg_24_3].light = gohelper.findChild(arg_24_1, "#go_FG")
		arg_24_0._expointObj[arg_24_3].mask = gohelper.findChild(arg_24_1, "#go_Mask")
		arg_24_0._expointObj[arg_24_3].ani = SLFramework.AnimatorPlayer.Get(arg_24_1)
	end
end

function var_0_0._onPoint2ItemShow(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_3 = arg_25_3 + 6

	if not arg_25_0._expointObj[arg_25_3] then
		arg_25_0._expointObj[arg_25_3] = arg_25_0:newUserDataTable()
		arg_25_0._expointObj[arg_25_3].light = gohelper.findChild(arg_25_1, "#go_FG")
		arg_25_0._expointObj[arg_25_3].mask = gohelper.findChild(arg_25_1, "#go_Mask")
		arg_25_0._expointObj[arg_25_3].ani = SLFramework.AnimatorPlayer.Get(arg_25_1)
	end
end

function var_0_0._refreshHp(arg_26_0, arg_26_1)
	local var_26_0 = FightDataHelper.entityMgr:getById(arg_26_0._entityId)
	local var_26_1 = var_26_0.attrMO.hp
	local var_26_2 = var_26_0.currentHp

	if arg_26_1 then
		arg_26_0:_releaseHpTween()

		arg_26_0._hpTween = ZProj.TweenHelper.DOFillAmount(arg_26_0._hpSlider, var_26_2 / var_26_1, 0.3)
	else
		arg_26_0._hpSlider.fillAmount = var_26_2 / var_26_1
	end
end

function var_0_0._releaseHpTween(arg_27_0)
	if arg_27_0._hpTween then
		ZProj.TweenHelper.KillById(arg_27_0._hpTween)

		arg_27_0._hpTween = nil
	end
end

function var_0_0.onClose(arg_28_0)
	arg_28_0:_releaseTween()
	arg_28_0:_releaseHpTween()
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0
