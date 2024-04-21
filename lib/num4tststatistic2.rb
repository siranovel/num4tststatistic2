require 'num4tststatistic'
require 'hypothTest3'

# 統計的仮説検定
module Num4TstStatistic2Lib
    class ParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @paraTest = Num4TstStatisticLib::ParametrixTestLib.new
        end
        # 正規母集団の母平均の検定
        #
        # @overload populationMean(xi, m0, a)
        #   @param  [Array]  xi データ(double[])
        #   @param  [double] m0 母平均
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   xi = [15.5, 15.7, 15.4, 15.4, 15.6, 15.4, 15.6, 15.5, 15.4]
        #   paraTest = Num4TstStatisticLib::ParametrixTestLib.new(hypothTest)
        #   paraTest.populationMean(xi, 15.4, 0.05)
        #   => true
        def populationMean(xi, m0, a)
            df = xi.size - 1
            statistic = @paraTest.populationMean(xi, m0)
            return @hypothTest3.tDistTest(statistic, df, a)
        end
        # 正規母集団の母分散の検定
        #
        # @overload populationVar(xi, sig0, a)
        #   @param  [Array]  xi データ(double[])
        #   @param  [double] sig0 母分散
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi = [35.2, 34.5, 34.9, 35.2, 34.8, 35.1, 34.9, 35.2, 34.9, 34.8]
        #   sd = 0.4
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.populationVar(xi, sd*sd, 0.05)
        #   => true
        def populationVar(xi, sig0, a)
            df = xi.size - 1
            statistic = @paraTest.populationVar(xi, sig0)
            return @hypothTest3.chi2DistTest(statistic, df, a)
        end
        # 母比率の検定量
        #
        # @overload populationRatio(m, n, p0, a)
        #   @param [int]     m m値
        #   @param [int]     n N値
        #   @param [double]  p0 母比率
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.populationRatio(29, 346, 0.12, 0.05)
        #   => true
        def populationRatio(m, n, p0, a)
            statistic = @paraTest.populationRatio(m, n, p0)
            return @hypothTest3.normDistTest(statistic, a)
        end
        # 2つの母平均の差の検定量
        # (等分散性を仮定)
        #
        # @overload diffPopulationMean2EquVar(xi1, xi2, a)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.diffPopulationMean2EquVar(xi1, xi2, 0.05)
        #   => false
        def diffPopulationMean2EquVar(xi1, xi2, a)
            n1 = xi1.size
            n2 = xi2.size
            df = n1 + n2 - 2
            statistic = @paraTest.diffPopulationMean2EquVar(xi1, xi2)
            return @hypothTest3.tDistTest(statistic, df, a)
        end
        # 2つの母平均の差の検定量
        # (不等分散性を仮定)
        #
        # @overload diffPopulationMean2UnEquVar(xi1, xi2, a)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.diffPopulationMean2UnEquVar(xi1, xi2, 0.05)
        #   => false
        def diffPopulationMean2UnEquVar(xi1, xi2, a)
            df = @paraTest.df4welch(xi1, xi2)
            statistic = @paraTest.diffPopulationMean2UnEquVar(xi1, xi2)
            return @hypothTest3.tDistTest(statistic, df, a)
        end
        # 対応のある2つの母平均の差の検定量
        #
        # @overload diffPopulationMean(xi1, xi2, a)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
        #   xi2 = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.diffPopulationMean(xi1, xi2, 0.05)
        #   => true
        def diffPopulationMean(xi1, xi2, a)
            n = xi1.size
            df = n - 1
            statistic = @paraTest.diffPopulationMean(xi1, xi2)
            return @hypothTest3.tDistTest(statistic, df, a)
        end
        # 2つの母分散の差の検定量
        #
        # @overload diffPopulationVar(xi1, xi2, a)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.diffPopulationVar(xi1, xi2, 0.05)
        #   => false
        def diffPopulationVar(xi1, xi2, a)
            nf = xi1.size - 1
            df = xi2.size - 1
            statistic = @paraTest.diffPopulationVar(xi1, xi2)
            return @hypothTest3.fDistTest(statistic, nf, df, a)
        end
        # 2つの母比率の差の検定量
        #
        # @overload diffPopulationRatio(m1, n1, m2, n2, a)
        #   @param [int] m1 m1値
        #   @param [int] n1 N1値
        #   @param [int] m2 m2値
        #   @param [int] n2 N2値
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.diffPopulationRatio(469, 1200, 308, 900, 0.05)
        #   => true
        def diffPopulationRatio(m1, n1, m2, n2, a)
            statistic = @paraTest.diffPopulationRatio(m1, n1, m2, n2)
            return @hypothTest3.normDistTest(statistic, a)
        end
        # 適合度の検定量
        #
        # @overload fidelity(fi, pi, a)
        #   @param [Array] fi 実測度数(double[])
        #   @param [Array] pi 比率(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   fi = [57, 33, 46, 14]
        #   pi = [0.4, 0.2, 0.3, 0.1]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.fidelity(fi, pi, 0.05)
        #   => false
        def fidelity(fi, pi, a)
            df = fi.size - 1
            statistic = @paraTest.fidelity(fi, pi)
            return @hypothTest3.chi2DistTest(statistic, df, a)
        end
        # 独立性の検定量
        #
        # @overload independency(fij, a)
        #   @param [Array] fij 実測度数(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   fij = [
        #     [57, 33, 46, 14],
        #     [89, 24, 75, 12],
        #   ]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest = Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest)
        #   paraTest.independency(fij, 0.05)
        #   => true
        def independency(fij, a)
            m = fij.size
            n = fij[0].size
            df = (m - 1) * (n - 1)
            statistic = @paraTest.independency(fij)
            return @hypothTest3.chi2DistTest(statistic, df, a)
        end
    end
    class NonParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        end
        # マン・ホイットニーのU検定
        #
        # @overload utest(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   x = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   y = [180, 180, 235, 270, 240, 285, 164, 152]
        #   nonParaTest = Num4TstStatistic2Lib::NonParametrixTestLib.new(hypothTest)
        #   nonParaTest.utest(x, y, 0.05)
        #   => true
        def utest(x, y, a)
            statistic = @nonParaTest.utest(x, y)
            return @hypothTest3.normDistTest(statistic, a)
        end
        # ウィルコクス符号付き順位検定
        #
        # @overload wilcoxontest(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   x = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
        #   y = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
        #   nonParaTest = Num4TstStatistic2Lib::NonParametrixTestLib.new(hypothTest)
        #   nonParaTest.wilcoxon(x, y, 0.05)
        #   => true
        def wilcoxon(x, y, a)
            statistic = @nonParaTest.wilcoxon(x, y)
            return @hypothTest3.normDistTest(statistic, a)
        end
        # コルモゴルフ・スミルノフ検定(2標本)
        #
        # @overload ks2test(xi1, xi2, a)
        #   @param [Array] xi1 x1のデータ(double[])
        #   @param [Array] xi2 x2のデータ(double[])
        #   @param [double] a         有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new(hypothTest)
        #   nonParaTest.ks2test(xi1, xi2, 0.05)
        #   => false
        def ks2test(xi1, xi2, a)
            return @nonParaTest.ks2test(xi1, xi2, a)
        end
    end
    class OutlierLib
        def initialize
            @outlier = Num4TstStatisticLib::OutlierLib.new
            @hypothTest2 = Num4HypothTestLib::GrubbsTestLib.new
        end
        # グラプス・スミルノフの外れ値の検定量
        #
        # @overload grubbs(xi, xk, a)
        #   @param [Array] xi xiのデータ(double[])
        #   @param [double] xk 外れ値
        #   @return [double] 検定統計量
        # @example
        #   xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
        #   outlier = Num4TstStatisticLib::OutlierLib.new
        #   outlier.grubbs(xi, 2.2, 0.05)
        #   => true
        def grubbs(xi, xk, a)
            n = xi.size
            statistic = @outlier.grubbs(xi, xk)
            @hypothTest2.twoSideTest(statistic, n, a)
        end
        # エラーバー出力
        #
        # @overload errbar(dname, xi)
        #   @param [String] dname データ名
        #   @param [Array] xi xiのデータ(double[])
        #   @return [void]  errbar.jpegファイルを出力
        # @example
        #   xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
        #   outlier = Num4TstStatisticLib::OutlierLib.new
        #   outlier.grubbs("LDH", xi)
        #   => errbar.jpeg
        def errbar(dname, xi)
            @outlier.errbar(dname, xi)
        end
    end
    # 無相関の検定
    class DecorrTestLib
        def initialize
            @paraTest = Num4TstStatisticLib::ParametrixTestLib.new
            @nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
            @hypothTest = Num4HypothTestLib::DecorrTestLib.new
        end
        # ピアソン相関係数
        #  (相関係数の検定)
        #
        # @overload pearsoCorrelation(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   paraTest = Num4TstStatistic2Lib::DecorrTestLib.new
        #   paraTest.pearsoCorrelation(x, y, 0.05)
        #   => true
        def pearsoCorrelation(x, y, a)
            df = x.size - 2
            statistic = @paraTest.pearsoCorrelation(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
        # スピアマンの順位相関係数
        #
        # @overload spearmanscorr(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   paraTest = Num4TstStatistic2Lib::DecorrTestLib.new
        #   paraTest.spearmanscorr(x, y, 0.05)
        #   => true
        def spearmanscorr(x, y, a)
            df = x.size - 2
            statistic = @nonParaTest.spearmanscorr(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
        # ケンドールの順位相関係数
        #
        # @overload kendallscorr(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   paraTest = Num4TstStatistic2Lib::DecorrTestLib.new
        #   paraTest.kendallscorr(x, y, 0.05)
        #   => false
        def kendallscorr(x, y, a)
            df = x.size - 2
            statistic = @nonParaTest.kendallscorr(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
    end
end
