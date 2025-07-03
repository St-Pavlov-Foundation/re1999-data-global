module("modules.logic.fight.model.data.FightCalculateDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightCalculateDataMgr", FightDataMgrBase)

function var_0_0.updateFightData(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.dataMgr.mgrList) do
		iter_1_1:updateData(arg_1_1)
	end
end

function var_0_0.beforePlayRoundData(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_0.dataMgr.handCardMgr:cacheDistributeCard(arg_2_1)
end

function var_0_0.afterPlayRoundData(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	if arg_3_1.actPoint then
		arg_3_0.dataMgr.operationDataMgr.actPoint = arg_3_1.actPoint
	end

	if arg_3_1.moveNum then
		arg_3_0.dataMgr.operationDataMgr.moveNum = arg_3_1.moveNum
	end
end

function var_0_0.playEffect2(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getTarEntityMO(arg_4_1)

	if not var_4_0 then
		return
	end

	var_4_0:setHp(var_4_0.currentHp - arg_4_1.effectNum)
end

function var_0_0.playEffect3(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getTarEntityMO(arg_5_1)

	if not var_5_0 then
		return
	end

	var_5_0:setHp(var_5_0.currentHp - arg_5_1.effectNum)
end

function var_0_0.playEffect4(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getTarEntityMO(arg_6_1)

	if not var_6_0 then
		return
	end

	var_6_0:setHp(var_6_0.currentHp + arg_6_1.effectNum)
end

function var_0_0.playEffect5(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getTarEntityMO(arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = arg_7_1.buff

	if not var_7_1 then
		return
	end

	var_7_0:addBuff(var_7_1)
end

function var_0_0.playEffect6(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getTarEntityMO(arg_8_1)

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_1.buff

	if not var_8_1 then
		return
	end

	var_8_0:delBuff(var_8_1.uid)
end

function var_0_0.playEffect7(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getTarEntityMO(arg_9_1)

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_1.buff

	if not var_9_1 then
		return
	end

	var_9_0:updateBuff(var_9_1)
end

function var_0_0.playEffect8(arg_10_0, arg_10_1)
	return
end

function var_0_0.playEffect9(arg_11_0, arg_11_1)
	arg_11_0.dataMgr.entityMgr:addDeadUid(arg_11_1.targetId)

	local var_11_0 = arg_11_0:getTarEntityMO(arg_11_1)

	if not var_11_0 then
		return
	end

	var_11_0:setDead()
end

function var_0_0.playEffect12(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getTarEntityMO(arg_12_1)

	if not var_12_0 then
		return
	end

	var_12_0:setHp(var_12_0.currentHp + arg_12_1.effectNum)
end

function var_0_0.playEffect13(arg_13_0, arg_13_1)
	return
end

function var_0_0.playEffect14(arg_14_0, arg_14_1)
	return
end

function var_0_0.playEffect15(arg_15_0, arg_15_1)
	return
end

function var_0_0.playEffect16(arg_16_0, arg_16_1)
	return
end

function var_0_0.playEffect17(arg_17_0, arg_17_1)
	return
end

function var_0_0.playEffect18(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getTarEntityMO(arg_18_1)

	if not var_18_0 then
		return
	end

	var_18_0:setHp(var_18_0.currentHp - arg_18_1.effectNum)
end

function var_0_0.playEffect19(arg_19_0, arg_19_1)
	return
end

function var_0_0.playEffect20(arg_20_0, arg_20_1)
	return
end

function var_0_0.playEffect21(arg_21_0, arg_21_1)
	return
end

function var_0_0.playEffect22(arg_22_0, arg_22_1)
	return
end

function var_0_0.playEffect23(arg_23_0, arg_23_1)
	return
end

function var_0_0.playEffect24(arg_24_0, arg_24_1)
	return
end

function var_0_0.playEffect25(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getTarEntityMO(arg_25_1)

	if not var_25_0 then
		return
	end

	var_25_0:setShield(arg_25_1.effectNum)
end

function var_0_0.playEffect26(arg_26_0, arg_26_1)
	return
end

function var_0_0.playEffect27(arg_27_0, arg_27_1)
	return
end

function var_0_0.playEffect28(arg_28_0, arg_28_1)
	return
end

function var_0_0.playEffect29(arg_29_0, arg_29_1)
	return
end

function var_0_0.playEffect30(arg_30_0, arg_30_1)
	return
end

function var_0_0.playEffect31(arg_31_0, arg_31_1)
	return
end

function var_0_0.playEffect32(arg_32_0, arg_32_1)
	return
end

function var_0_0.playEffect33(arg_33_0, arg_33_1)
	return
end

function var_0_0.playEffect34(arg_34_0, arg_34_1)
	return
end

function var_0_0.playEffect35(arg_35_0, arg_35_1)
	return
end

function var_0_0.playEffect36(arg_36_0, arg_36_1)
	return
end

function var_0_0.playEffect37(arg_37_0, arg_37_1)
	return
end

function var_0_0.playEffect38(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getTarEntityMO(arg_38_1)

	if not var_38_0 then
		return
	end

	var_38_0:setHp(var_38_0.currentHp - arg_38_1.effectNum)
end

function var_0_0.playEffect39(arg_39_0, arg_39_1)
	return
end

function var_0_0.playEffect40(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getTarEntityMO(arg_40_1)

	if not var_40_0 then
		return
	end

	var_40_0:setHp(arg_40_1.effectNum)
end

function var_0_0.playEffect41(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getTarEntityMO(arg_41_1)

	if not var_41_0 then
		return
	end

	var_41_0:setHp(var_41_0.currentHp + arg_41_1.effectNum)
	var_41_0:setShield(0)
end

function var_0_0.playEffect42(arg_42_0, arg_42_1)
	return
end

function var_0_0.playEffect43(arg_43_0, arg_43_1)
	return
end

function var_0_0.playEffect44(arg_44_0, arg_44_1)
	return
end

function var_0_0.playEffect45(arg_45_0, arg_45_1)
	return
end

function var_0_0.playEffect46(arg_46_0, arg_46_1)
	return
end

function var_0_0.playEffect47(arg_47_0, arg_47_1)
	return
end

function var_0_0.playEffect48(arg_48_0, arg_48_1)
	return
end

function var_0_0.playEffect49(arg_49_0, arg_49_1)
	return
end

function var_0_0.playEffect50(arg_50_0, arg_50_1)
	return
end

function var_0_0.playEffect51(arg_51_0, arg_51_1)
	return
end

function var_0_0.playEffect52(arg_52_0, arg_52_1)
	return
end

function var_0_0.playEffect53(arg_53_0, arg_53_1)
	return
end

function var_0_0.playEffect54(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0:getHandCard()
	local var_54_1 = arg_54_0.dataMgr.handCardMgr:getRedealCard()

	FightDataUtil.coverData(var_54_1, var_54_0)
	FightCardDataHelper.combineCardList(var_54_0, arg_54_0.dataMgr.entityMgr)
end

function var_0_0.playEffect55(arg_55_0, arg_55_1)
	return
end

function var_0_0.playEffect56(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0:getTarEntityMO(arg_56_1)

	if not var_56_0 then
		return
	end

	local var_56_1 = arg_56_1.buff

	if not var_56_1 then
		return
	end

	var_56_0:delBuff(var_56_1.uid)
end

function var_0_0.playEffect57(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getTarEntityMO(arg_57_1)

	if not var_57_0 then
		return
	end

	var_57_0:setHp(var_57_0.currentHp + arg_57_1.effectNum)
end

function var_0_0.playEffect58(arg_58_0, arg_58_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_58_1) then
		return
	end

	local var_58_0 = FightCardInfoData.New({
		uid = "0",
		skillId = arg_58_1.effectNum
	})
	local var_58_1 = arg_58_0:getHandCard()

	table.insert(var_58_1, var_58_0)
end

function var_0_0.playEffect59(arg_59_0, arg_59_1)
	arg_59_0.dataMgr.handCardMgr:distribute(arg_59_0.dataMgr.handCardMgr.beforeCards1, arg_59_0.dataMgr.handCardMgr.teamACards1)
end

function var_0_0.playEffect60(arg_60_0, arg_60_1)
	arg_60_0.dataMgr.handCardMgr:distribute(arg_60_0.dataMgr.handCardMgr.beforeCards2, arg_60_0.dataMgr.handCardMgr.teamACards2)
end

function var_0_0.playEffect61(arg_61_0, arg_61_1)
	return
end

function var_0_0.playEffect62(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0:getTarEntityMO(arg_62_1)

	if not var_62_0 then
		return
	end

	var_62_0:setShield(0)
end

function var_0_0.playEffect63(arg_63_0, arg_63_1)
	return
end

function var_0_0.playEffect64(arg_64_0, arg_64_1)
	return
end

function var_0_0.playEffect65(arg_65_0, arg_65_1)
	return
end

function var_0_0.playEffect66(arg_66_0, arg_66_1)
	return
end

function var_0_0.playEffect67(arg_67_0, arg_67_1)
	if not arg_67_1.entity then
		return
	end

	local var_67_0 = FightEntityMO.New()

	var_67_0:init(arg_67_1.entity)
	FightHelper.setEffectEntitySide(arg_67_1, var_67_0)
	arg_67_0.dataMgr.entityMgr:replaceEntityMO(var_67_0)
end

function var_0_0.playEffect68(arg_68_0, arg_68_1)
	return
end

function var_0_0.playEffect69(arg_69_0, arg_69_1)
	return
end

function var_0_0.playEffect70(arg_70_0, arg_70_1)
	return
end

function var_0_0.playEffect71(arg_71_0, arg_71_1)
	return
end

function var_0_0.playEffect72(arg_72_0, arg_72_1)
	return
end

function var_0_0.playEffect73(arg_73_0, arg_73_1)
	return
end

function var_0_0.playEffect74(arg_74_0, arg_74_1)
	return
end

function var_0_0.playEffect75(arg_75_0, arg_75_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_75_1) then
		return
	end

	local var_75_0 = arg_75_1.entity and arg_75_1.entity.id

	if not var_75_0 then
		return
	end

	local var_75_1 = arg_75_0.dataMgr:getEntityById(var_75_0)

	if not var_75_1 then
		return
	end

	local var_75_2 = FightModel.instance:getVersion()

	if var_75_2 < 1 and var_75_1.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local var_75_3 = arg_75_0:getHandCard()
	local var_75_4 = tonumber(arg_75_1.targetId)
	local var_75_5 = arg_75_1.effectNum

	if not var_75_3[var_75_4] then
		return
	end

	var_75_3[var_75_4].uid = var_75_0
	var_75_3[var_75_4].skillId = var_75_5

	if var_75_2 < 4 then
		FightCardDataHelper.combineCardList(var_75_3, arg_75_0.dataMgr.entityMgr)
	end
end

function var_0_0.playEffect76(arg_76_0, arg_76_1)
	return
end

function var_0_0.playEffect77(arg_77_0, arg_77_1)
	arg_77_0.dataMgr.operationDataMgr.extraMoveAct = arg_77_1.effectNum
end

function var_0_0.playEffect78(arg_78_0, arg_78_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_78_1) then
		return
	end

	local var_78_0 = FightCardInfoData.New({
		uid = "0",
		skillId = arg_78_1.effectNum
	})
	local var_78_1 = arg_78_0:getHandCard()

	table.insert(var_78_1, var_78_0)
end

function var_0_0.playEffect79(arg_79_0, arg_79_1)
	return
end

function var_0_0.playEffect80(arg_80_0, arg_80_1)
	return
end

function var_0_0.playEffect81(arg_81_0, arg_81_1)
	return
end

function var_0_0.playEffect82(arg_82_0, arg_82_1)
	return
end

function var_0_0.playEffect83(arg_83_0, arg_83_1)
	return
end

function var_0_0.playEffect84(arg_84_0, arg_84_1)
	return
end

function var_0_0.playEffect85(arg_85_0, arg_85_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_85_1) then
		return
	end

	local var_85_0 = string.splitToNumber(arg_85_1.reserveStr, "#")
	local var_85_1 = arg_85_0:getHandCard()

	for iter_85_0, iter_85_1 in ipairs(var_85_0) do
		local var_85_2 = FightCardInfoData.New(arg_85_1.cardInfoList[iter_85_0])

		if var_85_1[iter_85_1] then
			FightDataUtil.coverData(var_85_2, var_85_1[iter_85_1])
		end
	end
end

function var_0_0.playEffect86(arg_86_0, arg_86_1)
	if not arg_86_1.entity then
		return
	end

	local var_86_0 = FightModel.instance:getVersion()
	local var_86_1 = FightEntityMO.New()

	var_86_1:init(arg_86_1.entity)

	if var_86_0 >= 1 then
		local var_86_2 = arg_86_0.dataMgr.entityMgr:addEntityMO(var_86_1)
		local var_86_3 = arg_86_0.dataMgr.entityMgr:getOriginNormalList(var_86_2.side)

		table.insert(var_86_3, var_86_2)
	else
		FightHelper.setEffectEntitySide(arg_86_1, var_86_1)
		arg_86_0.dataMgr.entityMgr:addEntityMO(var_86_1)
	end
end

function var_0_0.playEffect87(arg_87_0, arg_87_1)
	return
end

function var_0_0.playEffect88(arg_88_0, arg_88_1)
	return
end

function var_0_0.playEffect89(arg_89_0, arg_89_1)
	return
end

function var_0_0.playEffect90(arg_90_0, arg_90_1)
	return
end

function var_0_0.playEffect91(arg_91_0, arg_91_1)
	local var_91_0 = arg_91_0:getTarEntityMO(arg_91_1)

	if not var_91_0 then
		return
	end

	if var_91_0:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	var_91_0:changeExpointMaxAdd(arg_91_1.effectNum)
end

function var_0_0.playEffect92(arg_92_0, arg_92_1)
	return
end

function var_0_0.playEffect93(arg_93_0, arg_93_1)
	return
end

function var_0_0.playEffect94(arg_94_0, arg_94_1)
	return
end

function var_0_0.playEffect95(arg_95_0, arg_95_1)
	return
end

function var_0_0.playEffect96(arg_96_0, arg_96_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_96_1) then
		return
	end

	local var_96_0 = arg_96_0:getHandCard()

	for iter_96_0 = #var_96_0, 1, -1 do
		local var_96_1 = var_96_0[iter_96_0]

		if FightEnum.UniversalCard[var_96_1.skillId] then
			table.remove(var_96_0, iter_96_0)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardList(var_96_0, arg_96_0.dataMgr.entityMgr)
	end
end

function var_0_0.playEffect97(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_0:getTarEntityMO(arg_97_1)

	if not var_97_0 then
		return
	end

	var_97_0.career = arg_97_1.effectNum
end

function var_0_0.playEffect98(arg_98_0, arg_98_1)
	return
end

function var_0_0.playEffect99(arg_99_0, arg_99_1)
	return
end

function var_0_0.playEffect100(arg_100_0, arg_100_1)
	return
end

function var_0_0.playEffect101(arg_101_0, arg_101_1)
	return
end

function var_0_0.playEffect102(arg_102_0, arg_102_1)
	return
end

function var_0_0.playEffect103(arg_103_0, arg_103_1)
	return
end

function var_0_0.playEffect104(arg_104_0, arg_104_1)
	return
end

function var_0_0.playEffect105(arg_105_0, arg_105_1)
	return
end

function var_0_0.playEffect106(arg_106_0, arg_106_1)
	return
end

function var_0_0.playEffect107(arg_107_0, arg_107_1)
	if not arg_107_1.entity then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		local var_107_0 = arg_107_0.dataMgr:getEntityById(arg_107_1.entity.id)
		local var_107_1 = var_107_0.side
		local var_107_2 = arg_107_0.dataMgr.entityMgr:getOriginSubList(var_107_1)
		local var_107_3 = arg_107_0:getTarEntityMO(arg_107_1)

		if var_107_3 and var_107_3.id ~= FightEntityScene.MySideId and var_107_3.id ~= FightEntityScene.EnemySideId then
			var_107_3.position = var_107_0.position or -1

			local var_107_4 = arg_107_0.dataMgr.entityMgr:getOriginListById(var_107_3.uid)

			for iter_107_0, iter_107_1 in ipairs(var_107_4) do
				if iter_107_1.uid == var_107_3.uid then
					table.remove(var_107_4, iter_107_0)

					break
				end
			end

			table.insert(var_107_2, var_107_3)
		end

		for iter_107_2, iter_107_3 in ipairs(var_107_2) do
			if iter_107_3.uid == var_107_0.uid then
				table.remove(var_107_2, iter_107_2)

				break
			end
		end

		local var_107_5 = FightEntityMO.New()

		var_107_5:init(arg_107_1.entity)
		arg_107_0.dataMgr.entityMgr:replaceEntityMO(var_107_5)

		local var_107_6 = arg_107_0.dataMgr.entityMgr:getOriginNormalList(var_107_1)

		table.insert(var_107_6, arg_107_0.dataMgr.entityMgr:getById(var_107_0.uid))
	else
		local var_107_7 = FightEntityMO.New()

		var_107_7:init(arg_107_1.entity)
		FightHelper.setEffectEntitySide(arg_107_1, var_107_7)
		arg_107_0.dataMgr.entityMgr:replaceEntityMO(arg_107_1.entity)
	end
end

function var_0_0.playEffect108(arg_108_0, arg_108_1)
	local var_108_0 = arg_108_0:getTarEntityMO(arg_108_1)

	if not var_108_0 then
		return
	end

	var_108_0.attrMO.hp = arg_108_1.effectNum
end

function var_0_0.playEffect109(arg_109_0, arg_109_1)
	local var_109_0 = arg_109_0:getTarEntityMO(arg_109_1)

	if not var_109_0 then
		return
	end

	var_109_0:setHp(arg_109_1.effectNum)
end

function var_0_0.playEffect110(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_0:getTarEntityMO(arg_110_1)

	if not var_110_0 then
		return
	end

	var_110_0:setHp(0)
end

function var_0_0.playEffect111(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0:getTarEntityMO(arg_111_1)

	if not var_111_0 then
		return
	end

	local var_111_1 = var_111_0:getExPoint() + (arg_111_1.effectNum or 0)

	var_111_0:setExPoint(var_111_1)
end

function var_0_0.playEffect112(arg_112_0, arg_112_1)
	return
end

function var_0_0.playEffect113(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_0:getTarEntityMO(arg_113_1)

	if not var_113_0 then
		return
	end

	var_113_0:changeServerUniqueCost(arg_113_1.effectNum)
end

function var_0_0.playEffect114(arg_114_0, arg_114_1)
	return
end

function var_0_0.playEffect115(arg_115_0, arg_115_1)
	return
end

function var_0_0.playEffect116(arg_116_0, arg_116_1)
	return
end

function var_0_0.playEffect117(arg_117_0, arg_117_1)
	local var_117_0 = tonumber(arg_117_1.targetId)
	local var_117_1 = arg_117_0.dataMgr.fieldMgr.indicatorDict

	if arg_117_1.configEffect == FightWorkIndicatorChange.ConfigEffect.AddIndicator then
		local var_117_2 = var_117_1[var_117_0]

		if not var_117_2 then
			var_117_2 = {
				num = 0,
				id = var_117_0
			}
			var_117_1[var_117_0] = var_117_2
		end

		var_117_2.num = arg_117_1.effectNum
	elseif arg_117_1.configEffect == FightWorkIndicatorChange.ConfigEffect.ClearIndicator then
		var_117_1[var_117_0] = nil
	end
end

function var_0_0.playEffect118(arg_118_0, arg_118_1)
	return
end

function var_0_0.playEffect119(arg_119_0, arg_119_1)
	return
end

function var_0_0.playEffect120(arg_120_0, arg_120_1)
	return
end

function var_0_0.playEffect121(arg_121_0, arg_121_1)
	return
end

function var_0_0.playEffect122(arg_122_0, arg_122_1)
	return
end

function var_0_0.playEffect123(arg_123_0, arg_123_1)
	return
end

function var_0_0.playEffect124(arg_124_0, arg_124_1)
	return
end

function var_0_0.playEffect125(arg_125_0, arg_125_1)
	if not arg_125_1.entity then
		return
	end

	local var_125_0 = FightModel.instance:getVersion()
	local var_125_1 = FightEntityMO.New()

	var_125_1:init(arg_125_1.entity)

	if var_125_0 >= 1 then
		arg_125_0.dataMgr.entityMgr:replaceEntityMO(var_125_1)
	else
		FightHelper.setEffectEntitySide(arg_125_1)
		arg_125_0.dataMgr.entityMgr:replaceEntityMO(var_125_1)
	end
end

function var_0_0.playEffect126(arg_126_0, arg_126_1)
	return
end

function var_0_0.playEffect127(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_0:getTarEntityMO(arg_127_1)

	if not var_127_0 then
		return
	end

	local var_127_1 = arg_127_1.configEffect

	if var_127_0:getPowerInfo(var_127_1) then
		var_127_0:changePowerMax(var_127_1, arg_127_1.effectNum)
	end
end

function var_0_0.playEffect128(arg_128_0, arg_128_1)
	local var_128_0 = arg_128_0:getTarEntityMO(arg_128_1)

	if not var_128_0 then
		return
	end

	local var_128_1 = arg_128_1.configEffect
	local var_128_2 = var_128_0:getPowerInfo(var_128_1)

	if var_128_2 then
		var_128_2.num = var_128_2.num + arg_128_1.effectNum
	end
end

function var_0_0.playEffect129(arg_129_0, arg_129_1)
	return
end

function var_0_0.playEffect130(arg_130_0, arg_130_1)
	local var_130_0 = arg_130_0:getTarEntityMO(arg_130_1)

	if not var_130_0 then
		return
	end

	var_130_0:setHp(var_130_0.currentHp - arg_130_1.effectNum)
end

function var_0_0.playEffect131(arg_131_0, arg_131_1)
	local var_131_0 = arg_131_0:getTarEntityMO(arg_131_1)

	if not var_131_0 then
		return
	end

	var_131_0:setHp(var_131_0.currentHp - arg_131_1.effectNum)
end

function var_0_0.playEffect132(arg_132_0, arg_132_1)
	return
end

function var_0_0.playEffect133(arg_133_0, arg_133_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_133_1) then
		return
	end

	local var_133_0 = string.splitToNumber(arg_133_1.reserveStr, "#")

	if #var_133_0 > 0 then
		local var_133_1 = arg_133_0:getHandCard()
		local var_133_2 = {}

		for iter_133_0, iter_133_1 in ipairs(var_133_0) do
			if var_133_1[iter_133_1] then
				var_133_2[iter_133_1] = true
			end
		end

		for iter_133_2 = #var_133_1, 1, -1 do
			if var_133_1[iter_133_2] and var_133_2[iter_133_2] then
				table.remove(var_133_1, iter_133_2)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightCardDataHelper.combineCardList(var_133_1, arg_133_0.dataMgr.entityMgr)
		end
	end
end

function var_0_0.playEffect134(arg_134_0, arg_134_1)
	local var_134_0 = arg_134_0:getTarEntityMO(arg_134_1)

	if not var_134_0 then
		return
	end

	if not arg_134_1.summoned then
		return
	end

	var_134_0:getSummonedInfo():addData(arg_134_1.summoned)
end

function var_0_0.playEffect135(arg_135_0, arg_135_1)
	local var_135_0 = arg_135_0:getTarEntityMO(arg_135_1)

	if not var_135_0 then
		return
	end

	local var_135_1 = var_135_0:getSummonedInfo()
	local var_135_2 = arg_135_1.reserveId

	if var_135_1:getData(var_135_2) then
		var_135_1:removeData(var_135_2)
	end
end

function var_0_0.playEffect136(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0:getTarEntityMO(arg_136_1)

	if not var_136_0 then
		return
	end

	local var_136_1 = var_136_0:getSummonedInfo()
	local var_136_2 = arg_136_1.reserveId
	local var_136_3 = var_136_1:getData(var_136_2)

	if var_136_3 then
		var_136_3.level = var_136_3.level + arg_136_1.effectNum
	end
end

function var_0_0.playEffect137(arg_137_0, arg_137_1)
	return
end

function var_0_0.playEffect138(arg_138_0, arg_138_1)
	return
end

function var_0_0.playEffect139(arg_139_0, arg_139_1)
	return
end

function var_0_0.playEffect140(arg_140_0, arg_140_1)
	return
end

function var_0_0.playEffect141(arg_141_0, arg_141_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_141_1) then
		return
	end

	local var_141_0 = string.splitToNumber(arg_141_1.reserveStr, "#")

	if #var_141_0 > 0 then
		local var_141_1 = arg_141_0:getHandCard()

		for iter_141_0, iter_141_1 in ipairs(var_141_0) do
			if var_141_1[iter_141_1] then
				var_141_1[iter_141_1].tempCard = true
			end
		end
	end
end

function var_0_0.playEffect142(arg_142_0, arg_142_1)
	return
end

function var_0_0.playEffect143(arg_143_0, arg_143_1)
	return
end

function var_0_0.playEffect144(arg_144_0, arg_144_1)
	return
end

function var_0_0.playEffect145(arg_145_0, arg_145_1)
	return
end

function var_0_0.playEffect146(arg_146_0, arg_146_1)
	return
end

function var_0_0.playEffect147(arg_147_0, arg_147_1)
	return
end

function var_0_0.playEffect148(arg_148_0, arg_148_1)
	return
end

function var_0_0.playEffect149(arg_149_0, arg_149_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_149_1) then
		return
	end

	local var_149_0 = FightCardInfoData.New(arg_149_1.cardInfo)
	local var_149_1 = arg_149_0:getHandCard()

	table.insert(var_149_1, var_149_0)

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardList(var_149_1, arg_149_0.dataMgr.entityMgr)
	end
end

function var_0_0.playEffect150(arg_150_0, arg_150_1)
	return
end

function var_0_0.playEffect151(arg_151_0, arg_151_1)
	return
end

function var_0_0.playEffect152(arg_152_0, arg_152_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_152_1) then
		return
	end

	local var_152_0 = arg_152_0:getHandCard()

	for iter_152_0 = #var_152_0, 1, -1 do
		if var_152_0[iter_152_0].uid == arg_152_1.targetId then
			table.remove(var_152_0, iter_152_0)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardList(var_152_0, arg_152_0.dataMgr.entityMgr)
	end
end

function var_0_0.playEffect153(arg_153_0, arg_153_1)
	local var_153_0 = arg_153_0:getHandCard()

	FightCardDataHelper.combineCardList(var_153_0, arg_153_0.dataMgr.entityMgr)
end

function var_0_0.playEffect154(arg_154_0, arg_154_1)
	local var_154_0 = arg_154_0:getHandCard()
	local var_154_1 = FightCardDataHelper.newCardList(arg_154_1.cardInfoList)

	FightDataUtil.coverData(var_154_1, var_154_0)
end

function var_0_0.playEffect155(arg_155_0, arg_155_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_155_1) then
		return
	end

	local var_155_0 = string.splitToNumber(arg_155_1.reserveStr, "#")

	if #var_155_0 > 0 then
		local var_155_1 = arg_155_0:getHandCard()
		local var_155_2 = {}

		for iter_155_0, iter_155_1 in ipairs(var_155_0) do
			if var_155_1[iter_155_1] then
				var_155_2[iter_155_1] = true
			end
		end

		for iter_155_2 = #var_155_1, 1, -1 do
			if var_155_1[iter_155_2] and var_155_2[iter_155_2] then
				table.remove(var_155_1, iter_155_2)
			end
		end
	end
end

function var_0_0.playEffect156(arg_156_0, arg_156_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_156_1) then
		return
	end

	local var_156_0 = arg_156_0:getHandCard()[arg_156_1.effectNum]

	if var_156_0 then
		FightDataUtil.coverData(FightCardInfoData.New(arg_156_1.cardInfo), var_156_0)
	end
end

function var_0_0.playEffect157(arg_157_0, arg_157_1)
	if FightModel.instance:getVersion() >= 1 and arg_157_1.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	local var_157_0 = arg_157_0:getHandCard()
	local var_157_1 = arg_157_1.effectNum

	if var_157_0[var_157_1] then
		table.remove(var_157_0, var_157_1)
	end
end

function var_0_0.playEffect158(arg_158_0, arg_158_1)
	return
end

function var_0_0.playEffect159(arg_159_0, arg_159_1)
	return
end

function var_0_0.playEffect160(arg_160_0, arg_160_1)
	return
end

function var_0_0.playEffect161(arg_161_0, arg_161_1)
	return
end

function var_0_0.playEffect162(arg_162_0, arg_162_1)
	if arg_162_0:isPerformanceData() then
		return
	end

	arg_162_0:playStepData(arg_162_1.fightStep)
end

function var_0_0.playEffect163(arg_163_0, arg_163_1)
	return
end

function var_0_0.playEffect164(arg_164_0, arg_164_1)
	return
end

function var_0_0.playEffect165(arg_165_0, arg_165_1)
	return
end

function var_0_0.playEffect166(arg_166_0, arg_166_1)
	return
end

function var_0_0.playEffect167(arg_167_0, arg_167_1)
	local var_167_0 = arg_167_0:getTarEntityMO(arg_167_1)

	if not var_167_0 then
		return
	end

	local var_167_1 = arg_167_1.buff

	if not var_167_1 then
		return
	end

	var_167_0:updateBuff(var_167_1)
end

function var_0_0.playEffect168(arg_168_0, arg_168_1)
	return
end

function var_0_0.playEffect169(arg_169_0, arg_169_1)
	return
end

function var_0_0.playEffect170(arg_170_0, arg_170_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_170_1) then
		return
	end

	local var_170_0 = arg_170_0:getHandCard()[arg_170_1.effectNum]

	if var_170_0 then
		FightDataUtil.coverData(FightCardInfoData.New(arg_170_1.cardInfo), var_170_0)
	end
end

function var_0_0.playEffect171(arg_171_0, arg_171_1)
	if not arg_171_0:getTarEntityMO(arg_171_1) then
		return
	end

	if not arg_171_1.entity then
		return
	end

	local var_171_0 = FightEntityMO.New()

	var_171_0:init(arg_171_1.entity)

	if FightModel.instance:getVersion() >= 1 then
		arg_171_0.dataMgr.entityMgr:replaceEntityMO(var_171_0)
	else
		FightHelper.setEffectEntitySide(arg_171_1, var_171_0)
		arg_171_0.dataMgr.entityMgr:replaceEntityMO(var_171_0)
	end
end

function var_0_0.playEffect172(arg_172_0, arg_172_1)
	return
end

function var_0_0.playEffect173(arg_173_0, arg_173_1)
	return
end

function var_0_0.playEffect174(arg_174_0, arg_174_1)
	local var_174_0 = arg_174_0:getTarEntityMO(arg_174_1)

	if not var_174_0 then
		return
	end

	var_174_0.canUpgradeIds[arg_174_1.effectNum] = arg_174_1.effectNum
end

function var_0_0.setRougeExData(arg_175_0, arg_175_1, arg_175_2)
	local var_175_0 = arg_175_0.dataMgr.fieldMgr.exTeamStr
	local var_175_1 = string.splitToNumber(var_175_0, "#")

	var_175_1[1] = var_175_1[1] or 0
	var_175_1[2] = var_175_1[2] or 0
	var_175_1[3] = var_175_1[3] or 0
	var_175_1[arg_175_1] = arg_175_2
	arg_175_0.dataMgr.fieldMgr.exTeamStr = string.format("%s#%s#%s", var_175_1[1], var_175_1[2], var_175_1[3])
end

function var_0_0.getRougeExData(arg_176_0, arg_176_1)
	return string.splitToNumber(arg_176_0.dataMgr.fieldMgr.exTeamStr, "#")[arg_176_1] or 0
end

function var_0_0.playEffect188(arg_177_0, arg_177_1)
	local var_177_0 = arg_177_0:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit)

	arg_177_0:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, var_177_0 + arg_177_1.effectNum)
end

function var_0_0.playEffect189(arg_178_0, arg_178_1)
	local var_178_0 = arg_178_0:getRougeExData(FightEnum.ExIndexForRouge.Magic)

	arg_178_0:setRougeExData(FightEnum.ExIndexForRouge.Magic, var_178_0 + arg_178_1.effectNum)
end

function var_0_0.playEffect190(arg_179_0, arg_179_1)
	local var_179_0 = arg_179_0:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	arg_179_0:setRougeExData(FightEnum.ExIndexForRouge.Coin, var_179_0 + arg_179_1.effectNum)
end

function var_0_0.playEffect191(arg_180_0, arg_180_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_180_1) then
		return
	end

	local var_180_0 = FightCardInfoData.New({
		uid = "0",
		skillId = arg_180_1.effectNum
	})
	local var_180_1 = arg_180_0:getHandCard()

	table.insert(var_180_1, var_180_0)
end

function var_0_0.playEffect192(arg_181_0, arg_181_1)
	local var_181_0 = arg_181_0:getTarEntityMO(arg_181_1)

	if not var_181_0 then
		return
	end

	var_181_0:setHp(var_181_0.currentHp - arg_181_1.effectNum)
end

function var_0_0.playEffect193(arg_182_0, arg_182_1)
	local var_182_0 = arg_182_0:getTarEntityMO(arg_182_1)

	if not var_182_0 then
		return
	end

	var_182_0:setHp(var_182_0.currentHp - arg_182_1.effectNum)
end

function var_0_0.playEffect195(arg_183_0, arg_183_1)
	local var_183_0 = arg_183_0:getTarEntityMO(arg_183_1)

	if not var_183_0 then
		return
	end

	var_183_0:setHp(var_183_0.currentHp + arg_183_1.effectNum)
end

function var_0_0.playEffect196(arg_184_0, arg_184_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_184_1) then
		return
	end

	local var_184_0 = string.splitToNumber(arg_184_1.reserveStr, "#")

	if #var_184_0 > 0 then
		local var_184_1 = arg_184_0:getHandCard()
		local var_184_2 = {}

		for iter_184_0, iter_184_1 in ipairs(var_184_0) do
			if var_184_1[iter_184_1] then
				var_184_2[iter_184_1] = true
			end
		end

		for iter_184_2 = #var_184_1, 1, -1 do
			if var_184_1[iter_184_2] and var_184_2[iter_184_2] then
				table.remove(var_184_1, iter_184_2)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightCardDataHelper.combineCardList(var_184_1, arg_184_0.dataMgr.entityMgr)
		end
	end
end

function var_0_0.playEffect197(arg_185_0, arg_185_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_185_1) then
		return
	end

	local var_185_0 = FightCardInfoData.New(arg_185_1.cardInfo)
	local var_185_1 = arg_185_0:getHandCard()

	table.insert(var_185_1, var_185_0)

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardList(var_185_1, arg_185_0.dataMgr.entityMgr)
	end
end

function var_0_0.playEffect202(arg_186_0, arg_186_1)
	local var_186_0 = arg_186_0:getTarEntityMO(arg_186_1)

	if not var_186_0 then
		return
	end

	var_186_0:setHp(var_186_0.currentHp - arg_186_1.effectNum)
end

function var_0_0.playEffect206(arg_187_0, arg_187_1)
	local var_187_0 = string.split(arg_187_1.reserveStr, "|")

	if #var_187_0 > 0 then
		for iter_187_0, iter_187_1 in ipairs(var_187_0) do
			local var_187_1 = string.split(iter_187_1, "#")
			local var_187_2 = var_187_1[1]
			local var_187_3 = tonumber(var_187_1[2]) or 1
			local var_187_4 = arg_187_0.dataMgr:getEntityById(var_187_2)

			if var_187_4 then
				var_187_4.position = var_187_3
			end
		end
	end
end

function var_0_0.playEffect207(arg_188_0, arg_188_1)
	local var_188_0 = arg_188_1.targetId
	local var_188_1 = arg_188_0.dataMgr:getEntityById(var_188_0)

	if var_188_1 then
		var_188_1.position = arg_188_1.effectNum
	end

	local var_188_2 = string.split(arg_188_1.reserveStr, "|")

	if #var_188_2 > 0 then
		for iter_188_0, iter_188_1 in ipairs(var_188_2) do
			local var_188_3 = string.split(iter_188_1, "#")
			local var_188_4 = var_188_3[1]
			local var_188_5 = tonumber(var_188_3[2]) or 1
			local var_188_6 = arg_188_0.dataMgr:getEntityById(var_188_4)

			if var_188_6 then
				var_188_6.position = var_188_5
			end
		end
	end
end

function var_0_0.playEffect208(arg_189_0, arg_189_1)
	local var_189_0 = arg_189_1.targetId
	local var_189_1 = arg_189_0.dataMgr:getEntityById(var_189_0)

	if var_189_1 then
		var_189_1.position = arg_189_1.effectNum
	end

	local var_189_2 = string.split(arg_189_1.reserveStr, "|")

	if #var_189_2 > 0 then
		for iter_189_0, iter_189_1 in ipairs(var_189_2) do
			local var_189_3 = string.split(iter_189_1, "#")
			local var_189_4 = var_189_3[1]
			local var_189_5 = tonumber(var_189_3[2]) or 1
			local var_189_6 = arg_189_0.dataMgr:getEntityById(var_189_4)

			if var_189_6 then
				var_189_6.position = var_189_5
			end
		end
	end
end

function var_0_0.playEffect212(arg_190_0, arg_190_1)
	arg_190_0.dataMgr.fieldMgr.curRound = (arg_190_0.dataMgr.fieldMgr.curRound or 1) + 1

	local var_190_0 = arg_190_0.dataMgr.entityMgr:getAllEntityMO()

	for iter_190_0, iter_190_1 in pairs(var_190_0) do
		iter_190_1.subCd = 0
	end
end

function var_0_0.playEffect214(arg_191_0, arg_191_1)
	local var_191_0 = arg_191_1.targetId
	local var_191_1 = arg_191_0.dataMgr:getEntityById(var_191_0)

	if var_191_1 then
		var_191_1:changeStoredExPoint(arg_191_1.effectNum)

		if arg_191_1.buff then
			var_191_1:updateBuff(arg_191_1.buff)
		end
	end
end

function var_0_0.playEffect228(arg_192_0, arg_192_1)
	local var_192_0 = arg_192_0:getTarEntityMO(arg_192_1)

	if not var_192_0 then
		return
	end

	var_192_0:setShield(arg_192_1.effectNum)
end

function var_0_0.playEffect233(arg_193_0, arg_193_1)
	arg_193_0.dataMgr.handCardMgr:distribute(arg_193_0.dataMgr.handCardMgr.beforeCards1, arg_193_0.dataMgr.handCardMgr.teamACards1)
end

function var_0_0.playEffect234(arg_194_0, arg_194_1)
	local var_194_0 = arg_194_0:getTarEntityMO(arg_194_1)

	if not var_194_0 then
		return
	end

	local var_194_1 = arg_194_1.buff

	if not var_194_1 then
		return
	end

	var_194_0:updateBuff(var_194_1)
end

function var_0_0.playEffect235(arg_195_0, arg_195_1)
	local var_195_0 = arg_195_0:getTarEntityMO(arg_195_1)

	if not var_195_0 then
		return
	end

	var_195_0.currentHp = var_195_0.currentHp + arg_195_1.effectNum
end

function var_0_0.playEffect236(arg_196_0, arg_196_1)
	local var_196_0 = arg_196_0:getTarEntityMO(arg_196_1)

	if not var_196_0 then
		return
	end

	var_196_0.guard = var_196_0.guard + arg_196_1.effectNum
end

function var_0_0.playEffect238(arg_197_0, arg_197_1)
	local var_197_0 = FightEntityMO.New()

	var_197_0:init(arg_197_1.entity)
	arg_197_0.dataMgr.entityMgr:replaceEntityMO(var_197_0)
end

function var_0_0.playEffect244(arg_198_0, arg_198_1)
	local var_198_0 = arg_198_0:getTarEntityMO(arg_198_1)

	if not var_198_0 then
		return
	end

	if not var_198_0:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	local var_198_1 = string.splitToNumber(arg_198_1.reserveStr, "#")
	local var_198_2 = var_198_1[1]
	local var_198_3 = var_198_1[2]
	local var_198_4 = var_198_0:getExpointMaxAddNum()

	var_198_0:changeExpointMaxAdd(var_198_2 - var_198_4)

	local var_198_5 = var_198_0:getExpointCostOffsetNum()

	var_198_0:changeServerUniqueCost(var_198_3 - var_198_5)
end

function var_0_0.playEffect247(arg_199_0, arg_199_1)
	local var_199_0 = arg_199_1.cardInfoList
	local var_199_1 = var_199_0 and #var_199_0

	arg_199_0.dataMgr.fieldMgr:changeDeckNum(var_199_1)
end

function var_0_0.playEffect248(arg_200_0, arg_200_1)
	local var_200_0 = arg_200_1.cardInfoList
	local var_200_1 = var_200_0 and #var_200_0

	arg_200_0.dataMgr.fieldMgr:changeDeckNum(-var_200_1)
end

function var_0_0.playEffect251(arg_201_0, arg_201_1)
	arg_201_0.dataMgr.fieldMgr.progress = arg_201_0.dataMgr.fieldMgr.progress + arg_201_1.effectNum
end

function var_0_0.playEffect252(arg_202_0, arg_202_1)
	arg_202_0.dataMgr.paTaMgr:setCurrCD(arg_202_1.effectNum)
end

function var_0_0.playEffect253(arg_203_0, arg_203_1)
	local var_203_0 = arg_203_0:getTarEntityMO(arg_203_1)

	if not var_203_0 then
		return
	end

	var_203_0:setHp(var_203_0.currentHp - arg_203_1.effectNum)
end

function var_0_0.playEffect256(arg_204_0, arg_204_1)
	arg_204_0.dataMgr.fieldMgr.progressMax = arg_204_0.dataMgr.fieldMgr.progressMax + arg_204_1.effectNum
	arg_204_0.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressSkill] = tonumber(arg_204_1.reserveStr)
	arg_204_0.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressId] = arg_204_1.effectNum1
end

function var_0_0.playEffect258(arg_205_0, arg_205_1)
	if arg_205_1.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	local var_205_0 = arg_205_0:getHandCard()
	local var_205_1 = arg_205_1.effectNum

	if var_205_0[var_205_1] then
		table.remove(var_205_0, var_205_1)
	end
end

function var_0_0.playEffect260(arg_206_0, arg_206_1)
	local var_206_0 = FightEntityMO.New()

	var_206_0:init(arg_206_1.entity)
	arg_206_0.dataMgr.entityMgr:replaceEntityMO(var_206_0)
end

function var_0_0.playEffect265(arg_207_0, arg_207_1)
	arg_207_0.dataMgr.paTaMgr:switchBossSkill(arg_207_1.assistBossInfo)
end

function var_0_0.playEffect267(arg_208_0, arg_208_1)
	local var_208_0 = arg_208_0:getTarEntityMO(arg_208_1)

	if not var_208_0 then
		return
	end

	var_208_0:setHp(var_208_0.currentHp - arg_208_1.effectNum)
end

function var_0_0.playEffect268(arg_209_0, arg_209_1)
	local var_209_0 = arg_209_0:getTarEntityMO(arg_209_1)

	if not var_209_0 then
		return
	end

	var_209_0:setHp(var_209_0.currentHp - arg_209_1.effectNum)
end

function var_0_0.playEffect269(arg_210_0, arg_210_1)
	return
end

function var_0_0.playEffect270(arg_211_0, arg_211_1)
	local var_211_0 = arg_211_0:getHandCard()
	local var_211_1 = string.splitToNumber(arg_211_1.reserveStr, "#")

	for iter_211_0 = #var_211_0, 1, -1 do
		if tabletool.indexOf(var_211_1, iter_211_0) then
			table.remove(var_211_0, iter_211_0)
		end
	end
end

function var_0_0.playEffect271(arg_212_0, arg_212_1)
	local var_212_0 = arg_212_0:getTarEntityMO(arg_212_1)

	if not var_212_0 then
		return
	end

	var_212_0:setShield(var_212_0.shieldValue + arg_212_1.effectNum)
end

function var_0_0.playEffect272(arg_213_0, arg_213_1)
	local var_213_0 = FightEnum.IndicatorId.PaTaScore
	local var_213_1 = arg_213_0.dataMgr.fieldMgr.indicatorDict[var_213_0]

	if not var_213_1 then
		var_213_1 = {
			num = 0,
			id = var_213_0
		}
		arg_213_0.dataMgr.fieldMgr.indicatorDict[var_213_0] = var_213_1
	end

	var_213_1.num = var_213_1.num + arg_213_1.effectNum
end

function var_0_0.playEffect273(arg_214_0, arg_214_1)
	arg_214_0.dataMgr.playCardMgr:setAct174EnemyCard(arg_214_1.cardInfoList)
end

function var_0_0.playEffect274(arg_215_0, arg_215_1)
	local var_215_0 = arg_215_0:getHandCard()
	local var_215_1 = FightCardDataHelper.newCardList(arg_215_1.cardInfoList)

	FightDataUtil.coverData(var_215_1, var_215_0)
end

function var_0_0.playEffect275(arg_216_0, arg_216_1)
	local var_216_0 = arg_216_1.effectNum

	arg_216_0.dataMgr.ASFDDataMgr:changeEnergy(var_216_0, arg_216_1.effectNum1)
end

function var_0_0.playEffect276(arg_217_0, arg_217_1)
	local var_217_0 = arg_217_0:getHandCard()
	local var_217_1 = FightCardDataHelper.newCardList(arg_217_1.cardInfoList)

	FightDataUtil.coverData(var_217_1, var_217_0)
end

function var_0_0.playEffect277(arg_218_0, arg_218_1)
	local var_218_0 = arg_218_1.effectNum

	arg_218_0.dataMgr.ASFDDataMgr:changeEmitterEnergy(var_218_0, arg_218_1.effectNum1)
end

function var_0_0.playEffect280(arg_219_0, arg_219_1)
	if not arg_219_1.emitterInfo then
		return
	end

	local var_219_0 = FightASFDEmitterInfoMO.New()

	var_219_0:init(arg_219_1.emitterInfo)

	local var_219_1 = FightEntityMO.New()

	var_219_1:init(arg_219_1.entity)

	local var_219_2 = arg_219_0.dataMgr.entityMgr:addEntityMO(var_219_1)
	local var_219_3 = arg_219_0.dataMgr.entityMgr:getOriginASFDEmitterList(var_219_2.side)

	table.insert(var_219_3, var_219_2)
	arg_219_0.dataMgr.ASFDDataMgr:setEmitterInfo(var_219_2.side, var_219_0)
end

function var_0_0.playEffect282(arg_220_0, arg_220_1)
	local var_220_0 = arg_220_0:getTarEntityMO(arg_220_1)

	if not var_220_0 then
		return
	end

	var_220_0:setHp(var_220_0.currentHp - arg_220_1.effectNum)
end

function var_0_0.playEffect283(arg_221_0, arg_221_1)
	arg_221_0.dataMgr.fieldMgr:setPlayerFinisherInfo(arg_221_1.playerFinisherInfo)
end

function var_0_0.playEffect287(arg_222_0, arg_222_1)
	local var_222_0 = arg_222_1.effectNum
	local var_222_1 = arg_222_0.dataMgr.entityMgr:getASFDEntityMo(var_222_0)

	if var_222_1 then
		arg_222_0.dataMgr.entityMgr:removeEntity(var_222_1.id)
	end
end

function var_0_0.playEffect289(arg_223_0, arg_223_1)
	return
end

function var_0_0.playEffect291(arg_224_0, arg_224_1)
	arg_224_0.dataMgr.tempMgr.simplePolarizationLevel = arg_224_1.effectNum
end

function var_0_0.playEffect293(arg_225_0, arg_225_1)
	local var_225_0 = arg_225_1.teamType == FightEnum.TeamType.MySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	local var_225_1 = arg_225_0.dataMgr.entityMgr:getOriginSubList(var_225_0)

	if not var_225_1 then
		return
	end

	local var_225_2 = FightEntityMO.New()

	var_225_2:init(arg_225_1.entity)

	local var_225_3 = arg_225_0.dataMgr.entityMgr:addEntityMO(var_225_2)

	table.insert(var_225_1, var_225_3)
end

function var_0_0.playEffect294(arg_226_0, arg_226_1)
	return
end

function var_0_0.playEffect295(arg_227_0, arg_227_1)
	local var_227_0 = arg_227_0:getTarEntityMO(arg_227_1)

	if not var_227_0 then
		return
	end

	if not arg_227_1.powerInfo then
		return
	end

	var_227_0:refreshPowerInfo(arg_227_1.powerInfo)
end

function var_0_0.playEffect306(arg_228_0, arg_228_1)
	local var_228_0 = arg_228_0:getTarEntityMO(arg_228_1)

	if not var_228_0 then
		return
	end

	local var_228_1 = arg_228_1.buff

	if not var_228_1 then
		return
	end

	var_228_0:updateBuff(var_228_1)
end

function var_0_0.playEffect308(arg_229_0, arg_229_1)
	local var_229_0 = arg_229_0.dataMgr.teamDataMgr[arg_229_1.teamType]
	local var_229_1 = arg_229_1.cardHeatValue.id
	local var_229_2 = var_229_0.cardHeat.values[var_229_1]

	var_229_0.cardHeat.values[var_229_1] = FightDataUtil.coverData(FightDataCardHeatValue.New(arg_229_1.cardHeatValue), var_229_2)
end

function var_0_0.playEffect309(arg_230_0, arg_230_1)
	local var_230_0 = arg_230_1.effectNum
	local var_230_1 = arg_230_0.dataMgr.teamDataMgr[arg_230_1.teamType].cardHeat.values[var_230_0]

	if not var_230_1 then
		return
	end

	var_230_1.value = var_230_1.value + arg_230_1.effectNum1
end

function var_0_0.playEffect310(arg_231_0, arg_231_1)
	local var_231_0 = arg_231_1.effectNum

	arg_231_0.dataMgr.fieldMgr:dirSetDeckNum(var_231_0)
end

function var_0_0.playEffect314(arg_232_0, arg_232_1)
	local var_232_0 = arg_232_0:getTarEntityMO(arg_232_1)

	if not var_232_0 then
		return
	end

	var_232_0:setHp(var_232_0.currentHp - arg_232_1.effectNum)
end

function var_0_0.playEffect316(arg_233_0, arg_233_1)
	if not arg_233_1.entity then
		return
	end

	local var_233_0 = FightEntityMO.New()

	var_233_0:init(arg_233_1.entity)
	arg_233_0.dataMgr.entityMgr:replaceEntityMO(var_233_0)
end

function var_0_0.playEffect320(arg_234_0, arg_234_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_234_1) then
		return
	end

	local var_234_0 = FightCardInfoData.New(arg_234_1.cardInfo)
	local var_234_1 = arg_234_0:getHandCard()

	table.insert(var_234_1, var_234_0)
end

function var_0_0.playEffect322(arg_235_0, arg_235_1)
	local var_235_0 = arg_235_0.dataMgr.entityMgr
	local var_235_1 = var_235_0:getOriginSubList(arg_235_1.teamType)

	if var_235_1 then
		for iter_235_0, iter_235_1 in ipairs(var_235_1) do
			var_235_0.entityDataDic[iter_235_1.uid] = nil
		end

		tabletool.clear(var_235_1)
	end
end

function var_0_0.playEffect323(arg_236_0, arg_236_1)
	local var_236_0 = arg_236_0.dataMgr.fieldMgr.fightTaskBox.tasks

	for iter_236_0, iter_236_1 in ipairs(arg_236_1.fightTasks) do
		local var_236_1 = iter_236_1.taskId
		local var_236_2 = FightTaskData.New(iter_236_1)

		var_236_0[var_236_1] = FightDataUtil.coverData(var_236_2, var_236_0[var_236_1])
	end
end

function var_0_0.playEffect325(arg_237_0, arg_237_1)
	arg_237_0.dataMgr.entityMgr:removeEntity(arg_237_1.targetId)
end

function var_0_0.playEffect326(arg_238_0, arg_238_1)
	local var_238_0 = arg_238_0:getTarEntityMO(arg_238_1)

	if not var_238_0 then
		return
	end

	local var_238_1 = arg_238_1.buff

	if not var_238_1 then
		return
	end

	var_238_0:updateBuff(var_238_1)
end

function var_0_0.playEffect330(arg_239_0, arg_239_1)
	local var_239_0 = arg_239_0.dataMgr.fieldMgr.param
	local var_239_1 = GameUtil.splitString2(arg_239_1.reserveStr, true)

	for iter_239_0, iter_239_1 in ipairs(var_239_1) do
		local var_239_2 = iter_239_1[1]
		local var_239_3 = iter_239_1[2]

		var_239_0[var_239_2] = (var_239_0[var_239_2] or 0) + var_239_3
	end
end

function var_0_0.playEffect337(arg_240_0, arg_240_1)
	arg_240_0.dataMgr:updateFightData(arg_240_1.fight)
end

function var_0_0.playEffect338(arg_241_0, arg_241_1)
	local var_241_0 = arg_241_0:getHandCard()
	local var_241_1 = FightStrUtil.instance:getSplitString2Cache(arg_241_1.reserveStr, true)

	for iter_241_0, iter_241_1 in ipairs(var_241_1) do
		local var_241_2 = iter_241_1[1]
		local var_241_3 = iter_241_1[2]

		for iter_241_2, iter_241_3 in ipairs(var_241_0) do
			if iter_241_2 == var_241_2 then
				iter_241_3.energy = iter_241_3.energy + var_241_3

				break
			end
		end
	end
end

function var_0_0.playUndefineEffect(arg_242_0)
	return
end

function var_0_0.dealExPointInfo(arg_243_0, arg_243_1)
	for iter_243_0, iter_243_1 in ipairs(arg_243_1) do
		local var_243_0 = arg_243_0.dataMgr:getEntityById(iter_243_1.uid)

		if var_243_0 then
			var_243_0:setHp(iter_243_1.currentHp)

			if not isDebugBuild then
				var_243_0:setExPoint(iter_243_1.exPoint)
				var_243_0:setPowerInfos(iter_243_1.powerInfos)
			end
		end
	end
end

function var_0_0.playChangeWave(arg_244_0)
	local var_244_0 = arg_244_0.dataMgr.cacheFightMgr:getAndRemove()

	if var_244_0 then
		arg_244_0.dataMgr:updateFightData(var_244_0)
	end
end

function var_0_0.playChangeHero(arg_245_0, arg_245_1)
	local var_245_0 = arg_245_0.dataMgr:getEntityById(arg_245_1.toId)
	local var_245_1 = arg_245_0.dataMgr:getEntityById(arg_245_1.fromId)

	if not var_245_1 then
		return
	end

	if var_245_0 and var_245_0.id ~= FightEntityScene.MySideId then
		var_245_1.position = var_245_0.position
		var_245_0.position = -1
	end

	if arg_245_1.actEffect then
		for iter_245_0, iter_245_1 in ipairs(arg_245_1.actEffect) do
			if iter_245_1.effectType == FightEnum.EffectType.CHANGEHERO then
				if FightModel.instance:getVersion() >= 1 then
					if iter_245_1.entity then
						local var_245_2 = FightEntityMO.New()

						var_245_2:init(iter_245_1.entity)
						arg_245_0.dataMgr.entityMgr:replaceEntityMO(var_245_2)
					end
				elseif iter_245_1.entity then
					local var_245_3 = FightEntityMO.New()

					var_245_3:init(iter_245_1.entity)
					FightHelper.setEffectEntitySide(iter_245_1, var_245_3)
					arg_245_0.dataMgr.entityMgr:replaceEntityMO(var_245_3)
				end
			end
		end
	end

	local var_245_4 = var_245_1.side
	local var_245_5 = arg_245_0.dataMgr.entityMgr:getOriginListById(arg_245_1.toId)

	for iter_245_2, iter_245_3 in ipairs(var_245_5) do
		if iter_245_3.uid == arg_245_1.toId then
			table.remove(var_245_5, iter_245_2)

			break
		end
	end

	local var_245_6 = arg_245_0.dataMgr.entityMgr:getOriginSubList(var_245_4)

	for iter_245_4, iter_245_5 in ipairs(var_245_6) do
		if iter_245_5.uid == arg_245_1.fromId then
			table.remove(var_245_6, iter_245_4)

			break
		end
	end

	local var_245_7 = arg_245_0.dataMgr.entityMgr:getOriginNormalList(var_245_4)

	table.insert(var_245_7, arg_245_0.dataMgr.entityMgr:getById(arg_245_1.fromId))
end

function var_0_0.getTarEntityMO(arg_246_0, arg_246_1)
	return arg_246_0.dataMgr:getEntityById(arg_246_1.targetId)
end

function var_0_0.getHandCard(arg_247_0)
	return arg_247_0.dataMgr.handCardMgr:getHandCard()
end

function var_0_0.needLogError(arg_248_0)
	if arg_248_0:isPerformanceData() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	return true
end

function var_0_0.isLocalData(arg_249_0)
	return arg_249_0.dataMgr.__cname == FightLocalDataMgr.__cname
end

function var_0_0.isPerformanceData(arg_250_0)
	return arg_250_0.dataMgr.__cname == FightDataMgr.__cname
end

function var_0_0.onConstructor(arg_251_0)
	arg_251_0._type2FuncName = {}
end

function var_0_0.playStepDataList(arg_252_0, arg_252_1)
	for iter_252_0, iter_252_1 in ipairs(arg_252_1) do
		arg_252_0:playStepData(iter_252_1)
	end
end

function var_0_0.playStepData(arg_253_0, arg_253_1)
	if arg_253_1.actType == FightEnum.ActType.SKILL or arg_253_1.actType == FightEnum.ActType.EFFECT then
		for iter_253_0, iter_253_1 in ipairs(arg_253_1.actEffect) do
			arg_253_0:playActEffectData(iter_253_1)
		end
	elseif arg_253_1.actType == FightEnum.ActType.CHANGEWAVE then
		arg_253_0:playChangeWave()
	elseif arg_253_1.actType == FightEnum.ActType.CHANGEHERO then
		arg_253_0:playChangeHero(arg_253_1)
	end
end

function var_0_0.playActEffectData(arg_254_0, arg_254_1)
	local var_254_0 = arg_254_0._type2FuncName[arg_254_1.effectType]

	if not var_254_0 then
		var_254_0 = arg_254_0["playEffect" .. arg_254_1.effectType] or arg_254_0.playUndefineEffect
		arg_254_0._type2FuncName[arg_254_1.effectType] = var_254_0
	end

	if arg_254_0:isPerformanceData() then
		arg_254_1:setDone()
		xpcall(var_254_0, var_0_0.ingoreLogError, arg_254_0, arg_254_1)
	else
		xpcall(var_254_0, __G__TRACKBACK__, arg_254_0, arg_254_1)
	end
end

function var_0_0.ingoreLogError(arg_255_0)
	return
end

return var_0_0
