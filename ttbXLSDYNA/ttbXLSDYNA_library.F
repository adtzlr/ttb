! -----------MODULE TENSORXLSDYNA-------------------------------
       module TensorXLSDYNA
       use Tensor 
       ! ---------------------------------------
       !
       ! ---------------------------------------
       ! 
       ! ---------------------------------------
       ! use this module in the following form:
       ! ---------------------------------------
       ! 
       ! ---------------------------------------
   
!      ------BEGIN INTERFACE-------------------------------------
       interface defoGrad
       module procedure vec9_LSTC_to_unsymTensor_2
       end interface
       
       interface ten_to_list
       module procedure ten_4_to_list_36
       end interface
       
       interface list_to_array
       module procedure list_36_to_array_6x6
       end interface
              
       interface sigX_to_ten
       module procedure sigX_to_ten_2
       end interface
       
       interface dX_to_ten
       module procedure dX_to_ten_2
       end interface
       
       interface ten_to_sigX
       module procedure ten_2_to_sigX
       end interface
!      ------END INTERFACE---------------------------------------
       
       contains

!      ------BEGIN FUNCTIONS-------------------------------------
       include './libdefoGrad.f'
!      ------TENSOR for umatV SECTION----------------------------
       include './libX_to_ten.f'
       include './libten_to_list.f'
!      ------END FUNCTIONS---------------------------------------
!      ------BEGIN SUBROUTINES-----------------------------------
       include './libten_to_X.f'
!      ------END SUBROUTINES-------------------------------------

       end module TensorXLSDYNA