!      ------DOT SECTION-----------------------------------------
!      ------SIMPLE DOT SECTION----------------------------------
!      ------REAL(KIND=8)----------------------------------------
       function dot_01(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_01

        dot_01%a = w * T%a
        
       end function dot_01
       
       function dot_10(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_10

        dot_10%a = w * T%a
        
       end function dot_10
       
       function dot_02(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_02

        dot_02%ab = w * T%ab
        
       end function dot_02
       
       function dot_02s(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_02s

        dot_02s%a6 = w * T%a6
        
       end function dot_02s
       
       function dot_20(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_20

        dot_20%ab = w * T%ab
        
       end function dot_20
       
       function dot_20s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_20s

        dot_20s%a6 = w * T%a6
        
       end function dot_20s
       
       function dot_04(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_04

        dot_04%abcd = w * T%abcd
        
       end function dot_04
       
       function dot_04s(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_04s

        dot_04s%a6b6 = w * T%a6b6
        
       end function dot_04s
       
       function dot_40(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_40

        dot_40%abcd = w * T%abcd
        
       end function dot_40
       
       function dot_40s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_40s

        dot_40s%a6b6 = w * T%a6b6
        
       end function dot_40s
!      ------REAL(KIND=4)----------------------------------------
       function dot_01_r4(w, T)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_01_r4

        dot_01_r4%a = dble(w) * T%a
        
       end function dot_01_r4
       
       function dot_10_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_10_r4

        dot_10_r4%a = dble(w) * T%a
        
       end function dot_10_r4
       
       function dot_02_r4(w, T)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_02_r4

        dot_02_r4%ab = dble(w) * T%ab
        
       end function dot_02_r4
       
       function dot_02s_r4(w, T)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_02s_r4

        dot_02s_r4%a6 = dble(w) * T%a6
        
       end function dot_02s_r4
       
       function dot_20_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_20_r4

        dot_20_r4%ab = dble(w) * T%ab
        
       end function dot_20_r4
       
       function dot_20s_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_20s_r4

        dot_20s_r4%a6 = dble(w) * T%a6
        
       end function dot_20s_r4
       
       function dot_04_r4(w, T)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_04_r4

        dot_04_r4%abcd = dble(w) * T%abcd
        
       end function dot_04_r4
       
       function dot_04s_r4(w, T)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_04s_r4

        dot_04s_r4%a6b6 = dble(w) * T%a6b6
        
       end function dot_04s_r4
       
       function dot_40_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_40_r4

        dot_40_r4%abcd = dble(w) * T%abcd
        
       end function dot_40_r4
       
       function dot_40s_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_40s_r4

        dot_40s_r4%a6b6 = dble(w) * T%a6b6
        
       end function dot_40s_r4
       
!      ------REAL(KIND=8)----------------------------------------
       function dot_21(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor1), intent(in) :: T2
        type(Tensor1) :: dot_21
        integer :: i, j
        
        do i = 1,3
         dot_21%a(i) = 0.d0
         do j = 1,3
          dot_21%a(i) = dot_21%a(i) + T1%ab(i,j)*T2%a(j)
         enddo
        enddo
        
       end function dot_21
       
       function dot_2s1(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1
        type(Tensor1), intent(in) :: T2
        type(Tensor1) :: dot_2s1

        dot_2s1%a(1)=T1%a6(1)*T2%a(1)+T1%a6(4)*T2%a(2)+T1%a6(6)*T2%a(3)
        dot_2s1%a(2)=T1%a6(4)*T2%a(1)+T1%a6(2)*T2%a(2)+T1%a6(5)*T2%a(3)
        dot_2s1%a(3)=T1%a6(6)*T2%a(1)+T1%a6(5)*T2%a(2)+T1%a6(3)*T2%a(3)
        
       end function dot_2s1
       
       function dot_12(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        type(Tensor1) :: dot_12
        integer :: i, j
        
        do i = 1,3
         dot_12%a(i) = 0.d0
         do j = 1,3
          dot_12%a(i) = dot_12%a(i) + T1%a(j)*T2%ab(j,i)
         enddo
        enddo
        
       end function dot_12
       
       function dot_12s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T2
        type(Tensor1), intent(in) :: T1
        type(Tensor1) :: dot_12s

        dot_12s%a(1)=T1%a(1)*T2%a6(1)+T1%a(2)*T2%a6(4)+T1%a(3)*T2%a6(6)
        dot_12s%a(2)=T1%a(1)*T2%a6(4)+T1%a(2)*T2%a6(2)+T1%a(3)*T2%a6(5)
        dot_12s%a(3)=T1%a(1)*T2%a6(6)+T1%a(2)*T2%a6(5)+T1%a(3)*T2%a6(3)
        
       end function dot_12s
       
       function dot_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1
        type(Tensor1), intent(in) :: T2
        real(kind=8) :: dot_11
        integer :: i
        
        dot_11 = 0.d0
        do i = 1,3
         dot_11 = dot_11 + T1%a(i)*T2%a(i)
        enddo
       end function dot_11
       
       function dot_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        type(Tensor2) :: dot_22
        integer :: i,j,k
        
        dot_22%ab = 0.d0
        do i = 1,3
         do j = 1,3
          do k = 1,3
           dot_22%ab(i,j) = dot_22%ab(i,j) + T1%ab(i,k)*T2%ab(k,j)
          enddo
         enddo
        enddo
       end function dot_22
       
       function dot_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor2) :: dot_2s2s

        dot_2s2s%ab(1,1) = T1%a6(1)*T2%a6(1)+T1%a6(4)*T2%a6(4)
     *                    +T1%a6(6)*T2%a6(6)
        dot_2s2s%ab(2,2) = T1%a6(4)*T2%a6(4)+T1%a6(2)*T2%a6(2)
     *                    +T1%a6(5)*T2%a6(5)
        dot_2s2s%ab(3,3) = T1%a6(6)*T2%a6(6)+T1%a6(5)*T2%a6(5)
     *                    +T1%a6(3)*T2%a6(3)
        dot_2s2s%ab(1,2) = T1%a6(1)*T2%a6(4)+T1%a6(4)*T2%a6(2)
     *                    +T1%a6(6)*T2%a6(5)
        dot_2s2s%ab(2,1) = T1%a6(4)*T2%a6(1)+T1%a6(2)*T2%a6(4)
     *                    +T1%a6(5)*T2%a6(6)
        dot_2s2s%ab(2,3) = T1%a6(4)*T2%a6(6)+T1%a6(2)*T2%a6(5)
     *                    +T1%a6(5)*T2%a6(3)
        dot_2s2s%ab(3,2) = T1%a6(6)*T2%a6(4)+T1%a6(5)*T2%a6(2)
     *                    +T1%a6(3)*T2%a6(5)
        dot_2s2s%ab(1,3) = T1%a6(1)*T2%a6(6)+T1%a6(4)*T2%a6(5)
     *                    +T1%a6(6)*T2%a6(3)
        dot_2s2s%ab(3,1) = T1%a6(6)*T2%a6(1)+T1%a6(5)*T2%a6(4)
     *                    +T1%a6(3)*T2%a6(6)
       end function dot_2s2s
