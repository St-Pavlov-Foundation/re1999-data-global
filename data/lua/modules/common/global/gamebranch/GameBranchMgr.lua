module("modules.common.global.gamebranch.GameBranchMgr", package.seeall)

local var_0_0 = string.format
local var_0_1 = _G.tonumber
local var_0_2 = _G.assert
local var_0_3 = class("GameBranchMgr")
local var_0_4 = false

local function var_0_5(arg_1_0)
	local var_1_0 = "AudioEnum%s_%s"
	local var_1_1 = 1
	local var_1_2 = 5

	arg_1_0.V = var_1_1
	arg_1_0.A = var_1_2

	while var_1_1 < math.huge do
		while var_1_2 < 10 do
			local var_1_3 = var_0_0(var_1_0, var_1_1, var_1_2)
			local var_1_4 = _G[var_1_3]

			if not var_1_4 then
				local var_1_5 = var_1_2

				while var_1_2 < 10 do
					var_1_2 = var_1_2 + 1

					local var_1_6 = var_0_0(var_1_0, var_1_1, var_1_2)

					var_1_4 = _G[var_1_6]

					if var_1_4 then
						break
					end
				end

				if var_1_5 == 0 and not var_1_4 then
					return
				end

				if var_1_2 >= 10 then
					break
				end
			end

			if var_1_2 == 0 and not var_1_4 then
				return
			elseif not var_1_4 then
				break
			end

			arg_1_0.V = var_1_1
			arg_1_0.A = var_1_2
			var_1_2 = var_1_2 + 1
		end

		var_1_1 = var_1_1 + 1
		var_1_2 = 0
	end
end

function var_0_3.ctor(arg_2_0)
	if not var_0_4 then
		var_0_4 = {}

		var_0_5(var_0_4)
	end

	arg_2_0._versionInfo = var_0_4
end

function var_0_3.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 or var_0_4.V
	arg_3_2 = arg_3_2 or var_0_4.A

	if var_0_1(arg_3_1) then
		var_0_2(var_0_1(arg_3_1) >= 1)

		arg_3_2 = arg_3_2 or 0
	else
		arg_3_1 = var_0_4.V
		arg_3_2 = var_0_4.A
	end

	arg_3_0:_init(arg_3_1, arg_3_2)
end

function var_0_3._init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._versionInfo = {
		V = arg_4_1,
		A = arg_4_2
	}

	if isDebugBuild then
		local var_4_0 = var_0_0("<color=#FFFF00>[GameBranchMgr] 当前版本: %s</color>", arg_4_0:VHyphenA())

		logNormal(var_4_0)
	end
end

function var_0_3.inject(arg_5_0)
	local var_5_0 = arg_5_0:versionFullInfo()

	arg_5_0:_module_views(var_5_0)
end

function var_0_3._module_views(arg_6_0, arg_6_1)
	local var_6_0 = require("modules.setting.module_views")

	ActivityController.instance:onModuleViews(arg_6_1, var_6_0)
end

function var_0_3.lastVersionInfo(arg_7_0)
	local var_7_0 = arg_7_0._versionInfo.V
	local var_7_1 = arg_7_0._versionInfo.A

	return arg_7_0:getLastVersionInfo(var_7_0, var_7_1)
end

function var_0_3.versionFullInfo(arg_8_0)
	local var_8_0 = arg_8_0._versionInfo
	local var_8_1 = arg_8_0:lastVersionInfo()

	return {
		curV = var_8_0.V,
		curA = var_8_0.A,
		lastV = var_8_1.V,
		lastA = var_8_1.A
	}
end

function var_0_3.getLastVersionInfo(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 <= 0 then
		arg_9_2 = 9
		arg_9_1 = arg_9_1 - 1
	end

	if arg_9_1 <= 0 then
		arg_9_1 = 1
		arg_9_2 = 0
	end

	return {
		V = arg_9_1,
		A = arg_9_2
	}
end

function var_0_3.getMajorVer(arg_10_0)
	return arg_10_0._versionInfo.V
end

function var_0_3.getMinorVer(arg_11_0)
	return arg_11_0._versionInfo.A
end

function var_0_3.VHyphenA(arg_12_0)
	return arg_12_0:getMajorVer() .. "-" .. arg_12_0:getMinorVer()
end

function var_0_3.getVxax(arg_13_0)
	return "V" .. arg_13_0:getMajorVer() .. "a" .. arg_13_0:getMinorVer()
end

function var_0_3.getvxax(arg_14_0)
	return "v" .. arg_14_0:getMajorVer() .. "a" .. arg_14_0:getMinorVer()
end

function var_0_3.getVxax_(arg_15_0)
	return arg_15_0:getVxax() .. "_"
end

function var_0_3.getvxax_(arg_16_0)
	return arg_16_0:getvxax() .. "_"
end

function var_0_3.getV_a(arg_17_0)
	return arg_17_0:getMajorVer() .. "_" .. arg_17_0:getMinorVer()
end

function var_0_3.getv_a(arg_18_0)
	return arg_18_0:getV_a()
end

function var_0_3.V_a(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or ""
	arg_19_2 = arg_19_2 or ""

	return arg_19_1 .. arg_19_0:getV_a() .. arg_19_2
end

function var_0_3.v_a(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0:V_a(arg_20_1, arg_20_2)
end

function var_0_3.Vxax(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or ""
	arg_21_2 = arg_21_2 or ""

	return arg_21_1 .. arg_21_0:getVxax() .. arg_21_2
end

function var_0_3.vxax(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 or ""
	arg_22_2 = arg_22_2 or ""

	return arg_22_1 .. arg_22_0:getvxax() .. arg_22_2
end

function var_0_3.Vxax_(arg_23_0, arg_23_1)
	return arg_23_0:getVxax_() .. arg_23_1
end

function var_0_3.vxax_(arg_24_0, arg_24_1)
	return arg_24_0:getvxax_() .. arg_24_1
end

function var_0_3.Vxax_ActId(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:Vxax_(arg_25_1)

	return ActivityEnum.Activity[var_25_0] or arg_25_2
end

function var_0_3.Vxax_ViewName(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:Vxax_(arg_26_1)

	return _G.ViewName[var_26_0] or arg_26_2
end

function var_0_3.isVer(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1 then
		return false
	end

	arg_27_2 = math.max(0, arg_27_2 or 0)

	local var_27_0 = arg_27_0:getMajorVer()

	if var_27_0 == arg_27_1 then
		return arg_27_2 <= arg_27_0:getMinorVer()
	end

	return arg_27_1 < var_27_0
end

function var_0_3.isOnVer(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_1 then
		return false
	end

	arg_28_2 = math.max(0, arg_28_2 or 0)

	local var_28_0 = arg_28_0:getMajorVer()
	local var_28_1 = arg_28_0:getMinorVer()

	return var_28_0 == arg_28_1 and var_28_1 == arg_28_2
end

function var_0_3.isOnPreVer(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 then
		return false
	end

	arg_29_2 = math.max(0, arg_29_2 or 0)

	local var_29_0 = arg_29_0:getMajorVer()

	if var_29_0 == arg_29_1 then
		return arg_29_2 >= arg_29_0:getMinorVer()
	end

	return var_29_0 < arg_29_1
end

function var_0_3.isV1a0(arg_30_0)
	return arg_30_0:isVer(1, 0)
end

function var_0_3.isV1a1(arg_31_0)
	return arg_31_0:isVer(1, 1)
end

function var_0_3.isV1a2(arg_32_0)
	return arg_32_0:isVer(1, 2)
end

function var_0_3.isV1a3(arg_33_0)
	return arg_33_0:isVer(1, 3)
end

function var_0_3.isV1a4(arg_34_0)
	return arg_34_0:isVer(1, 4)
end

function var_0_3.isV1a5(arg_35_0)
	return arg_35_0:isVer(1, 5)
end

function var_0_3.isV1a6(arg_36_0)
	return arg_36_0:isVer(1, 6)
end

function var_0_3.isV1a7(arg_37_0)
	return arg_37_0:isVer(1, 7)
end

function var_0_3.isV1a8(arg_38_0)
	return arg_38_0:isVer(1, 8)
end

function var_0_3.isV1a9(arg_39_0)
	return arg_39_0:isVer(1, 9)
end

function var_0_3.isV2a0(arg_40_0)
	return arg_40_0:isVer(2, 0)
end

function var_0_3.isV2a1(arg_41_0)
	return arg_41_0:isVer(2, 1)
end

function var_0_3.isV2a2(arg_42_0)
	return arg_42_0:isVer(2, 2)
end

function var_0_3.isV2a3(arg_43_0)
	return arg_43_0:isVer(2, 3)
end

function var_0_3.isV2a4(arg_44_0)
	return arg_44_0:isVer(2, 4)
end

function var_0_3.isV2a5(arg_45_0)
	return arg_45_0:isVer(2, 5)
end

function var_0_3.isV2a6(arg_46_0)
	return arg_46_0:isVer(2, 6)
end

function var_0_3.isV2a7(arg_47_0)
	return arg_47_0:isVer(2, 7)
end

function var_0_3.isV2a8(arg_48_0)
	return arg_48_0:isVer(2, 8)
end

function var_0_3.isV2a9(arg_49_0)
	return arg_49_0:isVer(2, 9)
end

function var_0_3.isV3a0(arg_50_0)
	return arg_50_0:isVer(3, 0)
end

function var_0_3.isV3a1(arg_51_0)
	return arg_51_0:isVer(3, 1)
end

function var_0_3.isV3a2(arg_52_0)
	return arg_52_0:isVer(3, 2)
end

function var_0_3.isV3a3(arg_53_0)
	return arg_53_0:isVer(3, 3)
end

function var_0_3.isV3a4(arg_54_0)
	return arg_54_0:isVer(3, 4)
end

function var_0_3.isV3a5(arg_55_0)
	return arg_55_0:isVer(3, 5)
end

function var_0_3.isV3a6(arg_56_0)
	return arg_56_0:isVer(3, 6)
end

function var_0_3.isV3a7(arg_57_0)
	return arg_57_0:isVer(3, 7)
end

function var_0_3.isV3a8(arg_58_0)
	return arg_58_0:isVer(3, 8)
end

function var_0_3.isV3a9(arg_59_0)
	return arg_59_0:isVer(3, 9)
end

function var_0_3.isV4a0(arg_60_0)
	return arg_60_0:isVer(4, 0)
end

function var_0_3.isV4a1(arg_61_0)
	return arg_61_0:isVer(4, 1)
end

function var_0_3.isV4a2(arg_62_0)
	return arg_62_0:isVer(4, 2)
end

function var_0_3.isV4a3(arg_63_0)
	return arg_63_0:isVer(4, 3)
end

function var_0_3.isV4a4(arg_64_0)
	return arg_64_0:isVer(4, 4)
end

function var_0_3.isV4a5(arg_65_0)
	return arg_65_0:isVer(4, 5)
end

function var_0_3.isV4a6(arg_66_0)
	return arg_66_0:isVer(4, 6)
end

function var_0_3.isV4a7(arg_67_0)
	return arg_67_0:isVer(4, 7)
end

function var_0_3.isV4a8(arg_68_0)
	return arg_68_0:isVer(4, 8)
end

function var_0_3.isV4a9(arg_69_0)
	return arg_69_0:isVer(4, 9)
end

function var_0_3.isV5a0(arg_70_0)
	return arg_70_0:isVer(5, 0)
end

function var_0_3.isV5a1(arg_71_0)
	return arg_71_0:isVer(5, 1)
end

function var_0_3.isV5a2(arg_72_0)
	return arg_72_0:isVer(5, 2)
end

function var_0_3.isV5a3(arg_73_0)
	return arg_73_0:isVer(5, 3)
end

function var_0_3.isV5a4(arg_74_0)
	return arg_74_0:isVer(5, 4)
end

function var_0_3.isV5a5(arg_75_0)
	return arg_75_0:isVer(5, 5)
end

function var_0_3.isV5a6(arg_76_0)
	return arg_76_0:isVer(5, 6)
end

function var_0_3.isV5a7(arg_77_0)
	return arg_77_0:isVer(5, 7)
end

function var_0_3.isV5a8(arg_78_0)
	return arg_78_0:isVer(5, 8)
end

function var_0_3.isV5a9(arg_79_0)
	return arg_79_0:isVer(5, 9)
end

function var_0_3.isV6a0(arg_80_0)
	return arg_80_0:isVer(6, 0)
end

function var_0_3.isV6a1(arg_81_0)
	return arg_81_0:isVer(6, 1)
end

function var_0_3.isV6a2(arg_82_0)
	return arg_82_0:isVer(6, 2)
end

function var_0_3.isV6a3(arg_83_0)
	return arg_83_0:isVer(6, 3)
end

function var_0_3.isV6a4(arg_84_0)
	return arg_84_0:isVer(6, 4)
end

function var_0_3.isV6a5(arg_85_0)
	return arg_85_0:isVer(6, 5)
end

function var_0_3.isV6a6(arg_86_0)
	return arg_86_0:isVer(6, 6)
end

function var_0_3.isV6a7(arg_87_0)
	return arg_87_0:isVer(6, 7)
end

function var_0_3.isV6a8(arg_88_0)
	return arg_88_0:isVer(6, 8)
end

function var_0_3.isV6a9(arg_89_0)
	return arg_89_0:isVer(6, 9)
end

function var_0_3.isV7a0(arg_90_0)
	return arg_90_0:isVer(7, 0)
end

function var_0_3.isV7a1(arg_91_0)
	return arg_91_0:isVer(7, 1)
end

function var_0_3.isV7a2(arg_92_0)
	return arg_92_0:isVer(7, 2)
end

function var_0_3.isV7a3(arg_93_0)
	return arg_93_0:isVer(7, 3)
end

function var_0_3.isV7a4(arg_94_0)
	return arg_94_0:isVer(7, 4)
end

function var_0_3.isV7a5(arg_95_0)
	return arg_95_0:isVer(7, 5)
end

function var_0_3.isV7a6(arg_96_0)
	return arg_96_0:isVer(7, 6)
end

function var_0_3.isV7a7(arg_97_0)
	return arg_97_0:isVer(7, 7)
end

function var_0_3.isV7a8(arg_98_0)
	return arg_98_0:isVer(7, 8)
end

function var_0_3.isV7a9(arg_99_0)
	return arg_99_0:isVer(7, 9)
end

function var_0_3.isV8a0(arg_100_0)
	return arg_100_0:isVer(8, 0)
end

function var_0_3.isV8a1(arg_101_0)
	return arg_101_0:isVer(8, 1)
end

function var_0_3.isV8a2(arg_102_0)
	return arg_102_0:isVer(8, 2)
end

function var_0_3.isV8a3(arg_103_0)
	return arg_103_0:isVer(8, 3)
end

function var_0_3.isV8a4(arg_104_0)
	return arg_104_0:isVer(8, 4)
end

function var_0_3.isV8a5(arg_105_0)
	return arg_105_0:isVer(8, 5)
end

function var_0_3.isV8a6(arg_106_0)
	return arg_106_0:isVer(8, 6)
end

function var_0_3.isV8a7(arg_107_0)
	return arg_107_0:isVer(8, 7)
end

function var_0_3.isV8a8(arg_108_0)
	return arg_108_0:isVer(8, 8)
end

function var_0_3.isV8a9(arg_109_0)
	return arg_109_0:isVer(8, 9)
end

function var_0_3.isV9a0(arg_110_0)
	return arg_110_0:isVer(9, 0)
end

function var_0_3.isV9a1(arg_111_0)
	return arg_111_0:isVer(9, 1)
end

function var_0_3.isV9a2(arg_112_0)
	return arg_112_0:isVer(9, 2)
end

function var_0_3.isV9a3(arg_113_0)
	return arg_113_0:isVer(9, 3)
end

function var_0_3.isV9a4(arg_114_0)
	return arg_114_0:isVer(9, 4)
end

function var_0_3.isV9a5(arg_115_0)
	return arg_115_0:isVer(9, 5)
end

function var_0_3.isV9a6(arg_116_0)
	return arg_116_0:isVer(9, 6)
end

function var_0_3.isV9a7(arg_117_0)
	return arg_117_0:isVer(9, 7)
end

function var_0_3.isV9a8(arg_118_0)
	return arg_118_0:isVer(9, 8)
end

function var_0_3.isV9a9(arg_119_0)
	return arg_119_0:isVer(9, 9)
end

var_0_3.instance = var_0_3.New()

return var_0_3
